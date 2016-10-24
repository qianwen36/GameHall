import('..comm.HallDataDef')
local mc = import('..comm.HallDef')
local target = cc.load('form').build('BaseHall', import('.interface.BaseHall'))
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

local TAG = 'Hall'
target.TAG = TAG

if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')
local ffi2 = MCClient.utils

function target:start( config )
	function config:getServer()
		return unpack(string.split(self.server, ':'))
	end
	function config:getVersion()
		local major, min, buildno = unpack(string.split(self.ver, '.'))
		return tonumber(major), tonumber(min), tonumber(buildno)
	end
	self.config_ = config
	self:restart(config)
end

function target:isConnected()
	return self.connected or false
end

function target:restart( config )
	if config == nil then return MCClient:reconnection(TAG) end
	
	config = config or self.config_
	local host, port = config:getServer()

	self.client = MCClient:connect(host, port, TAG,
	function (client, resp)
		local event = {'connected', 'error'}
		local des = MCClient:describe(resp)
		self.connected = MCClient:isConnected(resp)

		if not self.connected then
			self.ready = false
		end
		event = (self.connected and event[1]) or event[2]
		self:dispatchEvent({
			name = self.handler.CONNECTION,
			body = {event = event, msg = des, result = TAG}
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

function target:reqServers( desc, callack, notify )
	assert(type(desc) == 'table', 'reqServers( desc, callack, notify )#desc table excepted')
	desc = {
		handler = self.fillCommonData,
		nServerType = desc.nServerType or mc.ext.SERVER_TYPE_HALL
	}
	if notify then
		desc.dwGetFlags = mc.Flags.FLAG_GETSERVERS_NOTIFY
	end
	local data = self:requestData('GET_SERVERS', desc)

	local client = self.client
	if notify then
		client:on(mc.GET_SERVERS_OK, callack)
		callack = nil
	end
	client:send(mc.GET_SERVERS, data, callack)
end

function target:reqRoomsUserCount( param, start )-- param:room ids
	local client = self.client
	if start == 'start' then
		local function onNotify( _, resp, data )
			local event, msg, result = self.resolve(resp, mc.GET_ROOMUSERS_OK)
			if result then
				local ct, body = ffi2.vls_resolve('ITEM_COUNT', data)
				local c = ct.nCount
				local array = ffi2.vla_resolve('ITEM_USERS', c, body)
				result = {c, array}
			end
			result = result or nil
			self:log(':reqRoomsUserCount( param )#onNotify.', msg)
			self:dispatchEvent({
				name = self.handler.UPDATE_ROOMUSERSCOUNT,
				body = {event = event, msg = msg, result = result}
				})
		end

		client:on(mc.GET_ROOMUSERS_OK, onNotify)
	end
	local data, ct = self:requestData(
		'GET_ROOMUSERS', {
			handler = {self.fillCommonData, 'int'},
			affect = false,
			nRoomCount = #param,
			param
		} )
	client:send(mc.GET_ROOMUSERS, data)
--[[	local c = ct.head.nRoomCount
	local array = ct.array
	print('[GET_ROOMUSERS].'..c)
	for i=0,c-1 do
		local item = array[i]
		print('nRoomID['..i..'].'..item)
	end
	print('-----------------------')]]
end

function target:initHall(config)
	local REQUEST -- request id
	function self.initHall2( _, resp, data )
		local function proc( client )
			local result, event, msg, utfstr
			REQUEST = mc.GET_SERVERS
			if (MCClient.accept(resp)) then
				_, resp, data = client:syncSend(REQUEST, data)
			elseif resp == mc.GET_SERVERS_OK then
				client:off(mc.GET_SERVERS_OK)
			end
			event, msg, result = self.resolve(resp, mc.GET_SERVERS_OK)
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
			    	print('szServerName = '..self:string(item.szServerName) )
			    	print('szServerIP = '..self:string(item.szServerIP) )
			    	print('szWWW = ' ..self:string(item.szWWW) )
			    	print('szWWW2 = '..self:string(item.szWWW2))
			    	print('nUsersOnline = '..item.nUsersOnline)
			    	print('-------------------------------------')
			    end]]
			    result = {c, array}
			else
			    return self:log(mc.key(REQUEST), ".message:"..msg)
			end
			result = result or nil
			self:dispatchEvent({
				name = self.handler.GET_SERVERS,
				body = {event = event, msg = msg, result = result}
				})
			-- 获取大区列表
			REQUEST = mc.GET_AREAS
			_, resp, data = client:syncSend(REQUEST
				, self:requestData('GET_AREAS', {handler = self.fillCommonData}) )
			event, msg, result = self.resolve(resp)
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
				    print('szAreaName = '.. self:string(a.szAreaName) )
				    print('-------------------------------------')
				end]]
			    result = {c, array}
			else
			    return self:log(mc.key(REQUEST), ".message:"..msg)
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
				REQUEST = mc.GET_ROOMS
			    _, resp, data = client:syncSend(REQUEST
			    	, self:requestData('GET_ROOMS'
			    		, {handler = self.fillCommonData
			    		, nAreaID = info.nAreaID}) )
				event, msg, result = self.resolve(resp)
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
					    print('szRoomName = '..self:string(a.szRoomName) )
					    print('szGameIP = '..self:string(a.szGameIP) )
					    print('szPassword = '..self:string(a.szPassword) )
					    print('szWWW = '.. self:string(a.szWWW) )
					    print('-------------------------------------')
					end]]
				    result = {c, array}
				else
				    return self:log(mc.key(REQUEST), ".message:"..msg)
				end
				result = result or nil
				self:dispatchEvent({
					name = self.handler.GET_ROOMS,
					body = {event = event, msg = msg, result = result}
					})
			end
			self.ready = true
			self:dispatchEvent({
				name = self.handler.HALL_READY,
				})
		end
		MCClient:rpcall(TAG, proc)
	end
	local function proc( client )
		local _, resp, data, result, event, msg
		-- 获取大厅版本
		REQUEST = mc.CHECK_VERSION
		local major, min, buildno = config:getVersion()
		_, resp, data = client:syncSend(REQUEST
			, self:requestData('VERSION_MB', {
				handler = self.fillCommonData,
				nMajorVer = major,
				nMinorVer = min,
				nBuildNO = buildno,
				szExeName = config.target
				}) )
		event, msg, result = self.resolve(resp)
		if result then
			local t = ffi2.ct_resolve('CHECK_VERSION_OK_MB', data)
--[[			print('[CHECK_VERSION_OK_MB]')
			print('nMajorVer ='..t.nMajorVer)
			print('nMinorVer ='..t.nMinorVer)
			print('nBuildNO ='..t.nBuildNO)
			print('nCheckReturn ='..t.nCheckReturn)
			print('szDLFile ='..self:string(t.szDLFile) )
			print('szUpdateWWW ='..self:string(t.szUpdateWWW) )
			print('dwClientIP ='..t.dwClientIP)]]
			result = t
		else
		    return self:log(mc.key(REQUEST), ".message:"..msg)
		end
		result = result or nil
		self:dispatchEvent({
			name = self.handler.CHECK_VERSION,
			body = {event = event, msg = msg, result = result}
			})
		-- 获取大厅服务器
		local notify = DEBUG~=0
		if notify then
			self:reqServers({nServerType = mc.ext.SERVER_TYPE_HALL}, self.initHall2, notify)
			return
		end
		self.initHall2(_, resp, data) -- inner rpcall
	end
	MCClient:rpcall(TAG, proc)
	self:log(':initHall(config).done')
end

return target
