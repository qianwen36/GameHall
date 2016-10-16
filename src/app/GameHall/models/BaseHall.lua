require('src.app.GameHall.comm.HallDataDef')
local mc = require('src.app.GameHall.comm.HallDef')
local MCClient = require('src.app.TcyCommon.MCClient2')
local target = {}
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()
local event = cc.load('event'):create()
event:bind(target)

local ffi = require('ffi')
local ffi2 = MCClient.utils

target.on = event.addEventListener
target.TAG = 'Hall'
target.handler = {
	CONNECTION = 'CONNECTION',
	CHECK_VERSION = 'VERSION_MB',
	GET_SERVERS = 'GET_SERVERS',
	GET_AREAS = 'GET_AREAS',
	GET_ROOMS = 'GET_ROOMS',
}

function target:start( config )
	self.config_ = config
	self:restart(config)
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
	function REQ.GetRooms()
		return ffi2.ct_generate('GET_ROOMS', {
				nAreaID = 1583,
				nGameID = config.gameid,
				nAgentGroupID = config.agentGroup,
				dwGetFlags = FlagGET
			})
	end
	local function proc( client )
		local _, resp, data
	    local function routine( proc )
			if MCClient:accept(resp) then
				proc()
			else
			    print(self.TAG..".TEST:"..MCClient:describe(resp))
			end
	    end
		_, resp, data = client:syncSend(mc.CHECK_VERSION, REQ.checkVersion())
		if MCClient:accept(resp) then
			local t = ffi2.ct_resolve('CHECK_VERSION_OK_MB', data)
			print('[CHECK_VERSION_OK_MB]')
			print('nMajorVer ='..t.nMajorVer)
			print('nMinorVer ='..t.nMinorVer)
			print('nBuildNO ='..t.nBuildNO)
			print('nCheckReturn ='..t.nCheckReturn)
			print('szDLFile ='..ffi.string(t.szDLFile))
			print('szUpdateWWW ='..ffi.string(t.szUpdateWWW))
			print('dwClientIP ='..t.dwClientIP)
		else
		    print(self.TAG..".TEST:"..MCClient:describe(resp))
		end
		_, resp, data = client:syncSend(mc.GET_SERVERS, REQ.GetServers())
		if MCClient:accept(resp) or resp==mc.GET_SERVERS_OK then
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
		else
		    print(self.TAG..".TEST:"..MCClient:describe(resp))
		end
		_, resp, data = client:syncSend(mc.GET_AREAS, REQ.GetAreas())
		if MCClient:accept(resp) then
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
		else
		    print(self.TAG..".TEST:"..MCClient:describe(resp))
		end
	    _, resp, data = client:syncSend(mc.GET_ROOMS, REQ.GetRooms())
		if MCClient:accept(resp) then
			local ct, body = ffi2.vls_resolve('ROOMS', data)
			local c = ct.nRoomCount
			local array = ffi2.vla_resolve('ROOM', c, body)
			print('ROOM['..c..']# link('..ct.nLinkCount..')')
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
		else
		    print(self.TAG..".TEST:"..MCClient:describe(resp))
		end
	end
	MCClient:rpcall(self.TAG, proc)
end

return target
