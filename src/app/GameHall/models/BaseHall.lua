require('src.app.GameHall.comm.HallDataDef')
local mc = require('src.app.GameHall.comm.HallDef')
local target = {}
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()
local event = cc.load('event'):create()
event:bind(target)

target.on = target.addEventListener
target.TAG = 'Hall'
target.handler = {
	CONNECTION = 'CONNECTION',
	CHECK_VERSION = 'VERSION_MB',
	GET_SERVERS = 'GET_SERVERS',
	GET_AREAS = 'GET_AREAS',
	GET_ROOMS = 'GET_ROOMS',
	HALL_READY = 'READY'
}
if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')
local ffi = require('ffi')
local ffi2 = MCClient.utils

function target:start( config )
	self.config_ = config
	self:restart(config)
end

function target:login( ... )
	-- body
end

function target:restart( config )
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
			body = {event = event, msg = des}
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

function target:initHall(config)
	local REQ = {}
	function REQ.resolve( resp )
		local events = {'succeed', 'failed'}
		local result = MCClient:accept(resp)
		local msg = MCClient:describe(resp)
		local event = (result and events[1]) or events[2]
		return event, msg, result
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
	local FlagGET = 0x00000800
	function REQ.GetServers()
		local TYPE_Hall = 1
		local FLAG_nofity = 0x00000001
		local flags = FlagGET
		if DEBUG~=0 then
			bit.bor(flags, FLAG_nofity)
		end
	
		return ffi2.ct_generate('GET_SERVERS', {
				nGameID = config.gameid,
				nServerType = TYPE_Hall,
				nAgentGroupID = config.agentGroup,
				dwGetFlags = flags
			})
	end
	function REQ.GetAreas()
		return ffi2.ct_generate('GET_AREAS', {
				nGameID = config.gameid,
				nAgentGroupID = config.agentGroup,
				dwGetFlags = FlagGET
			})
	end
	function REQ.GetRooms(areaid)
		return ffi2.ct_generate('GET_ROOMS', {
				nAreaID = areaid,
				nGameID = config.gameid,
				nAgentGroupID = config.agentGroup,
				dwGetFlags = FlagGET
			})
	end
	local function proc( client )
		local _, resp, data, result, event, msg
		-- 获取大厅版本
		_, resp, data = client:syncSend(mc.CHECK_VERSION, REQ.checkVersion())
		event, msg, result = REQ.resolve(resp)
		if result then
			local t = ffi2.ct_resolve('CHECK_VERSION_OK_MB', data)
			print('[CHECK_VERSION_OK_MB]')
			print('nMajorVer ='..t.nMajorVer)
			print('nMinorVer ='..t.nMinorVer)
			print('nBuildNO ='..t.nBuildNO)
			print('nCheckReturn ='..t.nCheckReturn)
			print('szDLFile ='..ffi.string(t.szDLFile))
			print('szUpdateWWW ='..ffi.string(t.szUpdateWWW))
			print('dwClientIP ='..t.dwClientIP)
			result = t
		else
		    return print(self.TAG..".TEST:"..msg)
		end
		result = result or nil
		self:dispatchEvent({
			name = 'CHECK_VERSION',
			body = {event = event, msg = msg, result = result}
			})
		-- 获取大厅服务器
		_, resp, data = client:syncSend(mc.GET_SERVERS, REQ.GetServers())
		event, msg, result = REQ.resolve(resp)
		if result then
			local ct, body = ffi2.vls_resolve('SERVERS', data)
			local c = ct.nServerCount
			local array = ffi2.vla_resolve('SERVER', c, body)
		    print('SERVER['..c..']')
			print('-------------------------------------')
		    for i=0, c-1 do
                local item = array[i]
		    	print('nServerID = '..item.nServerID)
		    	print('nServerType = '.. item.nServerType)
		    	print('szServerName = '.. ffi.string(item.szServerName, 32))
		    	print('szServerIP = '.. ffi.string(item.szServerIP, 32))
		    	print('szWWW = '.. ffi.string(item.szWWW,  64))
		    	print('szWWW2 = '.. ffi.string(item.szWWW2,64))
		    	print('nUsersOnline = '..item.nUsersOnline)
		    	print('-------------------------------------')
		    end
		    result = {c, array}
		else
		    return print(self.TAG..".TEST:"..msg)
		end
		result = result or nil
		self:dispatchEvent({
			name = 'GET_SERVERS',
			body = {event = event, msg = msg, result = result}
			})
		-- 获取大区列表
		_, resp, data = client:syncSend(mc.GET_AREAS, REQ.GetAreas())
		event, msg, result = REQ.resolve(resp)
		if result then
			local ct, body = ffi2.vls_resolve('AREAS', data)
			local c = ct.nCount
			local array = ffi2.vla_resolve('AREA', c, body)
			print('AREA['..c..']#')
			print('-------------------------------------')
			for i=0, c-1 do
			    local a = array[i]
			    print('nAreaID = '..a.nAreaID)
			    print('nAreaType = '..a.nAreaType)
			    print('nSubType = '..a.nSubType)
			    print('nGifID = '..a.nGifID)
			    print('nServerID = '..a.nServerID)
			    print('szAreaName = '.. ffi.string(a.szAreaName))
			    print('-------------------------------------')
			end
		    result = {c, array}
		else
		    return print(self.TAG..".TEST:"..msg)
		end
		result = result or nil
		self:dispatchEvent({
			name = 'GET_AREAS',
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
				print('ROOM['..c..']# link('..ct.nLinkCount..')@area.'..info.nAreaID)
				print('-------------------------------------')
				for i=0, c-1 do
				    local a = array[i]
				    print('nRoomID = '..a.nRoomID)
				    print('nRoomType = '..a.nRoomType)
				    print('nTableCount = '..a.nTableCount)
				    print('nUsersOnline = '..a.nUsersOnline)
				    print('nPort = '..a.nPort)
				    print('nGamePort = '..a.nGamePort)
				    print('szRoomName = '..ffi.string(a.szRoomName))
				    print('szGameIP = '..ffi.string(a.szGameIP))
				    print('szPassword = '..ffi.string(a.szPassword))
				    print('szWWW = '.. ffi.string(a.szWWW))
				    print('-------------------------------------')
				end
			    result = {c, array}
			else
			    return print(self.TAG..".TEST:"..msg)
			end
			result = result or nil
			self:dispatchEvent({
				name = 'GET_ROOMS',
				body = {event = event, msg = msg, result = result}
				})
		end
		self:dispatchEvent({
			name = 'READY',
			})
	end
	MCClient:rpcall(self.TAG, proc)
end

return target
