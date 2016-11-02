local target = cc.load('form').build('BaseHall', import('.interface.BaseModel'))

if not USING_MCRuntime then return target end

local mc = import('src.app.GameHall.comm.HallDef')
local ffi = require('ffi')
local MCClient = require('src.app.TcyCommon.MCClient2')
local ffi2 = MCClient.utils
local MCCharset = MCCharset:getInstance()
local DeviceUtils = DeviceUtils:getInstance()
local BusinessUtils = BusinessUtils:getInstance()

function target:genDataREQ( ctype, desc ) -- 生成序列化请求数据
--[[
	desc = {handler = {target.fillCommData, 'int'}, affect = false}
	-- affect field `dwGetFlags`
--]]
	local param, fill, item = desc.handler
	if type(param) == 'table' and type(param[#param])=='string' then
		item = table.remove(param)
	end
	fill = param
	
	local t = type(fill)
	assert(t=='table' or 'function', 'desc.handler[1] must be a target:function or a list function for target')
	if t == 'table' then
		for i,fill_ in ipairs(fill) do
			fill_(self, desc)
		end
	else
		fill(self, desc)
	end
	-- remove the key used temporary
	desc.handler = nil
	desc.affect = nil
	if (item) then
		return ffi2.vls_generate(ctype, item, desc)
	end
	return ffi2.ct_generate(ctype, desc)
end

function target:fillCommonData(desc)
	local config = self:getConfig('hall').config

	local utils = HslUtils:getInstance()

	local fill = {
		nGameID = config.gameid,
		nRecommenderID = config.recommender or tonumber(BusinessUtils:getTcyPromoter()),
		nAgentGroupID = config.agentGroup or utils:getHallSvrAgentGroup(),
		dwGetFlags = bit.bor(desc.dwGetFlags or 0, mc.Flags.USER_TYPE_HANDPHONE)
	}
	local affect = desc.affect
	if affect~=nil and not affect then
		fill.dwGetFlags = desc.dwGetFlags
	end
	table.merge(desc, fill)
	return desc
end

function target:fillDeviceData(desc)
	local config = self:getConfig('hall').config
	local fill = {
		szHardID = config.MAC or DeviceUtils:getMacAddress(),
		szVolumeID = config.SYS or DeviceUtils:getSystemId(),
		szMachineID = config.IMEI or DeviceUtils:getIMEI(),
		dwSysVer = config.SysVersion or DeviceUtils:getSystemVersion(),
	}
	table.merge(desc, fill)
	return desc
end

--[[
function target:string( str ) -- overload]]
function target:string( str, raw ) -- raw = 'raw'; make cdata become a lua string encoded with UTF8
	assert(type(raw)=='string' or raw == nil, 'target:string(str, raw) #raw expect string')


	raw = raw or 'utf8'
	local handler = {utf8 = true, raw = true}
	function handler.utf8( ... )
		str = ffi.string(str)
		local len = string.len(str)
		if len == 0 then return str end

		return MCCharset:gb2Utf8String(str, len)
	end
	function handler.raw( ... )
		local len = string.len(str)
		if len == 0 then return str end

		return MCCharset:utf82GbString(str, len)
	end

	handler = handler[raw]
	return handler and handler()
end

--[[
function target.resolve( resp, reference )	-- overload #1:number
function target.resolve( value )			-- overload #1:table
function target.resolve( ctype, {cfield, ctype, data} ) -- overload #1:string, #2:table
function target.resolve( ctype, data )	-- overload #1:string, #2:cdata ]]
function target.resolve( arg, arg2 )

	local function event_resolve( value )
		if value.event == 'succeed' then
			local res = {}
			local data = value.result
			local c = data[1]
			local array = data[2]
			for i=1, c do
				res[i] = {data = array[i-1]}
			end
			return res
		end
	end
	local handler = {string = true, number = true, table = true}
	function handler.number( ... )
		local resp, reference = ctype, arg2
		local events = {'succeed', 'failed'}
		local result = MCClient:isConnected(resp) or MCClient:accept(resp) or (resp == reference)
		local msg = MCClient:describe(resp) or 'response.'..mc.key(resp)
		if string.len(msg)==0 then
			msg = 'notification from server'
		end

		local event = (result and events[1]) or events[2]
		return event, msg, result
	end
	function handler.string( ... )
		local ctype, data = arg, arg2
		local cfield, itype
		if type(data) == 'table' then
			cfield, itype, data = unpack(data)
		end
		if type(itype) == 'string'
		and type(cfield)== 'string' then
			local ct, value = ffi2.vls_resolve(ctype, data)
			local c = ct[cfield]
			local array = ffi2.vla_resolve(itype, c, value)
			return {c, array}
		end
		return ffi2.ct_resolve(ctype, data)
	end
	function handler.table( ... )
		local value = arg
		return event_resolve(value)
	end

	handler = handler[type(value)]
	if handler then
		return handler()
	end
--	return handler and handler()
end

--[[
function target:routine( resp, {REQUEST, reference}, func ) -- overload
function target:routine( resp, REQUEST, func ) -- overload func(event, msg, result)
function target:routine( resp, REQUEST, funs ) -- overload funs{function(event, msg, result)}]]
function target:routine( resp, arg0, args )
	local REQUEST, reference, func, t
	t = type(args) 
	if t == 'table' then -- overload #args
		func = args[mc.key(resp)]
		t = type(func)
		if t =='function' 
		or t =='string' then
			reference = resp
		end 
	elseif t =='function' then
		func = args
	end
	if type(arg0) == 'table' then -- overload #arg0
		REQUEST, reference = unpack(arg0)
	else
		REQUEST = arg0
	end
	local event, msg, result = self.resolve(resp, reference)
	if (result) then
		if t == 'string' then
			local str = func
			self:dispatchEvent({
				name = self.EVENT_SHOWTIP,
				value = {event = event, msg = msg, result = str}
				})
			return false
		end
		if t ~= 'function' then
			self:log(':routine( resp, arg0, args )#args except a function or a table of function(event, msg, result)')
			return false 
		end
		local name, res = func(event, msg, result)
		if type(name)=='string' then
			self:dispatchEvent({
				name = name,
				value = {event = event, msg = msg, result = res}
				})
		end
		return res
	else
		local req = mc.key(REQUEST) or REQUEST
		self:log(req, ">>>FAILED.message:", msg)
		self:exception({event = req, msg = msg})
	end
	return false
end

return target