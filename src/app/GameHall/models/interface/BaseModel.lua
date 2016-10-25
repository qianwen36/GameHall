local target = cc.load('form').build('BaseModel')

cc.bind(target, 'event')

if not USING_MCRuntime then return target end

local mc = import('src.app.GameHall.comm.HallDef')
local ffi = require('ffi')
local MCClient = require('src.app.TcyCommon.MCClient2')
local ffi2 = MCClient.utils
local MCCharset = MCCharset:getInstance()
local DeviceUtils = DeviceUtils:getInstance()

function target:on(eventName, listener, tag)
	return self:addEventListener(eventName, listener, tag)
end

function target:off( tag )
	return self:removeEventListenersByTag(tag)
end

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

	if (item) then
		return ffi2.vls_generate(ctype, item, desc)
	end
	return ffi2.ct_generate(ctype, desc)
end

function target:fillCommonData(desc)
	local config = self:getConfig('hall').config

	local utils = HslUtils:create(config.abbr) -- safe, once create

	local fill = {
		nGameID = config.gameid,
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

local function body_resolve( body )
	local res = {}
	local data = body.result
	local c = data[1]
	local array = data[2]
	for i=1, c do
		res[i] = {data = array[i-1]}
	end
	return res
end
--[[
function target.resolve( body ) -- overload]]
function target.resolve( resp, notify )
	local handler = {number = true, table = true}
	local body = resp
	function handler.number( ... )
		local events = {'succeed', 'failed'}
		local result = MCClient:accept(resp) or (resp == notify)
		local msg = MCClient:describe(resp)
		if string.len(msg)==0 then
			msg = 'notification from server'
		end

		local event = (result and events[1]) or events[2]
		return event, msg, result
	end
	function handler.table( ... )
		local event = body.event
		if event == 'succeed' then
			return body_resolve(body)
		end
	end
	handler = handler[type(body)]
	if handler then
		return handler()
	end
--	return handler and handler()
end


function target:getConfig( name )
	return self.app_:getConfig(name)
end

function target:getApp()
	return self.app_
end


function target:init( app )
	self.app_ = app
	return self
end

return target