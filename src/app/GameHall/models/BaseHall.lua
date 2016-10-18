import('..comm.HallDataDef')
local mc = import('..comm.HallDef')
local target = cc.load('form').build('BaseHall', import('.interface.BaseHall'))
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

target.TAG = 'Hall'
if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')
local ffi = require('ffi')
local ffi2 = MCClient.utils
local MCCharset = MCCharset:getInstance()

function target:start( config )
	self.config_ = config
	self:restart(config)
end

function target:isConnected()
	return self.connected or false
end

function target:restart( config )
	if config == nil then return MCClient:reconnection(self.TAG) end
	
	config = config or self.config_
	local host, port = unpack(string.split(config.server, ':'))

	self.client = MCClient:connect(host, port, self.TAG,
	function (client, resp)
		local event = {'connected', 'error'}
		local des = MCClient:describe(resp)
		self.connected = MCClient:isConnected(resp)

		event = (self.connected and event[1]) or event[2]
		self:dispatchEvent({
			name = self.handler.CONNECTION,
			body = {event = event, msg = des, result = self.TAG}
			})
		if self.connected then
			self.timer = Scheduler:scheduleScriptFunc(function ( t )
				local timer = self.timer
				self.timer = timer and Scheduler:unscheduleScriptEntry(timer)
				self:initHall(config)
			end, 0, false)
		end
	end)
end

local function getREQ( config )
local REQ = {}
function REQ.resolve( resp )
	local events = {'succeed', 'failed'}
	local result = MCClient:accept(resp)
	local msg = MCClient:describe(resp)
	if string.len(msg)==0 then
		msg = 'notification from server'
	end

	local event = (result and events[1]) or events[2]
	return event, msg, result
end
local function body_resolve( body )
	local res = {}
	local data = body.result
	local c = data[1]
	local array = data[2]
	for i=1, c do
		res[i] = array[i-1]
	end
	return res
end
function REQ.body_resolve( body )
	local event = body.event
	if event == 'succeed' then
		return body_resolve(body)
	end
end

function REQ.checkVersion()
	local major, min, buildno = unpack(string.split(config.ver, '.'))
	return ffi2.ct_generate('VERSION_MB', {
		nMajorVer = tonumber(major),
		nMinorVer = tonumber(min),
		nBuildNO = tonumber(buildno),
		nGameID = config.gameid,
		szExeName = config.target
		})
end

function REQ.GetServers(des)
	local flags = mc.Flags.USER_TYPE_HANDPHONE
	des = des or {}
	local notify = des.notify or false
	if notify then
		bit.bor(flags, mc.Flags.FLAG_GETSERVERS_NOTIFY)
	end
	local nGameID, nServerType, nAgentGroupID
	if type(des) == 'table' then
		nGameID = des.nGameID or config.gameid
		nServerType = des.nServerType or mc.ext.SERVER_TYPE_HALL
		nAgentGroupID = des.nAgentGroupID or config.agentGroup
	end

	return ffi2.ct_generate('GET_SERVERS', {
			nGameID = nGameID,
			nServerType = nServerType,
			nAgentGroupID = nAgentGroupID,
			dwGetFlags = flags
		})
end
function REQ.GetAreas()
	return ffi2.ct_generate('GET_AREAS', {
			nGameID = config.gameid,
			nAgentGroupID = config.agentGroup,
			dwGetFlags = mc.Flags.USER_TYPE_HANDPHONE
		})
end
function REQ.GetRooms(areaid)
	return ffi2.ct_generate('GET_ROOMS', {
			nAreaID = areaid,
			nGameID = config.gameid,
			nAgentGroupID = config.agentGroup,
			dwGetFlags = mc.Flags.USER_TYPE_HANDPHONE
		})
end
function REQ.RoomsUserCount(param)
	return ffi2.ct_generate('GET_ROOMUSERS',{
		nAgentGroupID = config.agentGroup,
		nRoomID = param
		})
end
print(target.TAG..'getREQ(config).done')
return REQ
end

function target:reqServers( data, callack, notify )
	if type(data) ~= 'string' then
		data = self.REQ.GetServers(data, {notify = notify})
	end
	if notify then
		MCClient:on(mc.GET_SERVERS_OK, callack)
	end
	local client = self.client
	client:send(mc.GET_SERVERS, data)
end
function target:reqRoomsUserCount( param )-- param:room ids
	MCClient:rpcall(function ( client )
		local _, resp, data = client:syncSend(mc.GET_SERVERS, self.REQ.RoomsUserCount(param))
	end)
end

local function GB2utf8string( str )
    local len = string.len(str)
	return (len > 0 and MCCharset:gb2Utf8String(str, len) ) or str
end
function target:initHall(config)
	local REQ = getREQ(config) -- for generate request data
	self.REQ = REQ
	function self:body_resolve( body )
		return REQ.body_resolve(body)
	end
	function self.initHall2( _, resp, data )
		local function proc( client )
			local result, event, msg, utfstr
			if (MCClient.accept(resp)) then
				_, resp, data = client:syncSend(mc.GET_SERVERS, data)
			elseif resp == mc.GET_SERVERS_OK then
				client:off(mc.GET_SERVERS_OK)
			end
			event, msg, result = REQ.resolve(resp)
			if result then
				local ct, body = ffi2.vls_resolve('SERVERS', data)
				local c = ct.nServerCount
				local array = ffi2.vla_resolve('SERVER', c, body)
--[[			    print('SERVER['..c..']')
				print('-------------------------------------')
			    for i=0, c-1 do
	                local item = array[i]
			    	print('nServerID = '..item.nServerID)
			    	print('nServerType = '.. item.nServerType)
			    	print('szServerName = '..GB2utf8string(ffi.string(item.szServerName)) )
			    	print('szServerIP = '..GB2utf8string(ffi.string(item.szServerIP)) )
			    	print('szWWW = ' ..GB2utf8string(ffi.string(item.szWWW)) )
			    	print('szWWW2 = '..GB2utf8string(ffi.string(item.szWWW2)))
			    	print('nUsersOnline = '..item.nUsersOnline)
			    	print('-------------------------------------')
			    end]]
			    result = {c, array}
			else
			    return print(self.TAG..".TEST:"..msg)
			end
			result = result or nil
			self:dispatchEvent({
				name = self.handler.GET_SERVERS,
				body = {event = event, msg = msg, result = result}
				})
			-- 获取大区列表
			_, resp, data = client:syncSend(mc.GET_AREAS, REQ.GetAreas())
			event, msg, result = REQ.resolve(resp)
			if result then
				local ct, body = ffi2.vls_resolve('AREAS', data)
				local c = ct.nCount
				local array = ffi2.vla_resolve('AREA', c, body)
--[[				print('AREA['..c..']#')
				print('-------------------------------------')
				for i=0, c-1 do
				    local a = array[i]
				    print('nAreaID = '..a.nAreaID)
				    print('nAreaType = '..a.nAreaType)
				    print('nSubType = '..a.nSubType)
				    print('nGifID = '..a.nGifID)
				    print('nServerID = '..a.nServerID)
				    print('szAreaName = '.. GB2utf8string(ffi.string(a.szAreaName)) )
				    print('-------------------------------------')
				end]]
			    result = {c, array}
			else
			    return print(self.TAG..".TEST:"..msg)
			end
			result = result or nil
			self:dispatchEvent({
				name = self.handler.GET_AREAS,
				body = {event = event, msg = msg, result = result}
				})
			local ar = result or {}
			local count = ar[1] or 0
			for i=0, count-1 do
				local info = ar[2][i]
			    _, resp, data = client:syncSend(mc.GET_ROOMS, REQ.GetRooms(info.nAreaID))
				event, msg, result = REQ.resolve(resp)
				if result then
					local ct, body = ffi2.vls_resolve('ROOMS', data)
					local c = ct.nRoomCount
					local array = ffi2.vla_resolve('ROOM', c, body)
--[[					print('ROOM['..c..']# link('..ct.nLinkCount..')@area.'..info.nAreaID)
					print('-------------------------------------')
					for i=0, c-1 do
					    local a = array[i]
					    print('nRoomID = '..a.nRoomID)
					    print('nRoomType = '..a.nRoomType)
					    print('nTableCount = '..a.nTableCount)
					    print('nUsersOnline = '..a.nUsersOnline)
					    print('nPort = '..a.nPort)
					    print('nGamePort = '..a.nGamePort)
					    print('szRoomName = '..GB2utf8string(ffi.string(a.szRoomName)) )
					    print('szGameIP = '..GB2utf8string(ffi.string(a.szGameIP)) )
					    print('szPassword = '..GB2utf8string(ffi.string(a.szPassword)) )
					    print('szWWW = '.. GB2utf8string(ffi.string(a.szWWW)) )
					    print('-------------------------------------')
					end]]
				    result = {c, array}
				else
				    return print(self.TAG..".TEST:"..msg)
				end
				result = result or nil
				self:dispatchEvent({
					name = self.handler.GET_ROOMS,
					body = {event = event, msg = msg, result = result}
					})
			end
			self:dispatchEvent({
				name = self.handler.HALL_READY,
				})
		end
		MCClient:rpcall(self.TAG, proc)
	end
	local function proc( client )
		local _, resp, data, result, event, msg
		-- 获取大厅版本
		_, resp, data = client:syncSend(mc.CHECK_VERSION, REQ.checkVersion())
		event, msg, result = REQ.resolve(resp)
		if result then
			local t = ffi2.ct_resolve('CHECK_VERSION_OK_MB', data)
--[[			print('[CHECK_VERSION_OK_MB]')
			print('nMajorVer ='..t.nMajorVer)
			print('nMinorVer ='..t.nMinorVer)
			print('nBuildNO ='..t.nBuildNO)
			print('nCheckReturn ='..t.nCheckReturn)
			print('szDLFile ='..GB2utf8string(ffi.string(t.szDLFile)) )
			print('szUpdateWWW ='..GB2utf8string(ffi.string(t.szUpdateWWW)) )
			print('dwClientIP ='..t.dwClientIP)]]
			result = t
		else
		    return print(self.TAG..".TEST:"..msg)
		end
		result = result or nil
		self:dispatchEvent({
			name = self.handler.CHECK_VERSION,
			body = {event = event, msg = msg, result = result}
			})
		-- 获取大厅服务器
		local data= REQ.GetServers({notify = DEBUG~=0})
		if notify then
			self:reqServers(data, self.initHall2, notify)
			return
		end
		self.initHall2(_, resp, data) -- inner rpcall
	end
	MCClient:rpcall(self.TAG, proc)
	print(self.TAG..'initHall(config).done')
end

return target
