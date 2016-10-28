import('..comm.HallDataDef')
local mc = import('..comm.HallDef')
local target = cc.load('form').build('BaseHall', import('.interface.BaseHall'))
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

local TAG = target.TAG

if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')
local ffi2 = MCClient.utils

function target:start( config )
	function config:getServer()
		return unpack(string.split(self.server, ':'))
	end
	function config:getVersion()
		local major, minor, buildno = unpack(string.split(self.version, '.'))
		return tonumber(major), tonumber(minor), tonumber(buildno)
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
	local data = self:genDataREQ('GET_SERVERS', desc)

	local client = self.client
	if notify then
		client:on(mc.GET_SERVERS_OK, callack)
		callack = nil
	end
	client:send(mc.GET_SERVERS, data, callack)
end

function target:reqRoomsUserCount( param, start )-- param:room ids
	local client = self.client
	local REQUEST = mc.GET_ROOMUSERS
	if start == 'start' then
		local function onNotify( _, resp, data )
			local result = self:routine(resp, {REQUEST, mc.GET_ROOMUSERS_OK}, function (event, msg, result)
				return self.handler.UPDATE_ROOMUSERSCOUNT, self.resolve('ITEM_COUNT', {'nCount', 'ITEM_USERS', data})
			end)

		end

		client:on(mc.GET_ROOMUSERS_OK, onNotify)
	end
	local data, ct = self:genDataREQ(
		'GET_ROOMUSERS', {
			handler = {self.fillCommonData, 'int'},
			affect = false,
			nRoomCount = #param,
			param
		} )
	client:send(REQUEST, data)
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
			local result
			REQUEST = mc.GET_SERVERS
			if (MCClient.accept(resp)) then
				_, resp, data = client:syncSend(REQUEST, data)
			elseif resp == mc.GET_SERVERS_OK then
				client:off(mc.GET_SERVERS_OK)
			end
			result = self:routine(resp, {REQUEST, mc.GET_SERVERS_OK}, function (event, msg, result)
				return self.handler.GET_SERVERS, self.resolve('SERVERS', {'nServerCount', 'SERVER', data})
			end)
			if result == false then return end

			-- 获取大区列表
			REQUEST = mc.GET_AREAS
			_, resp, data = client:syncSend(REQUEST
				, self:genDataREQ('GET_AREAS', {handler = self.fillCommonData}) )

			result = self:routine(resp, REQUEST, function (event, msg, result)
				return self.handler.GET_AREAS, self.resolve('AREAS', {'nCount', 'AREA', data})
			end)
			if result == false then return end

			local ar = result or {}
			local count = ar[1] or 0
			for i=0, count-1 do
				local info = ar[2][i]
				REQUEST = mc.GET_ROOMS
			    _, resp, data = client:syncSend(REQUEST
			    	, self:genDataREQ('GET_ROOMS'
			    		, {handler = self.fillCommonData
			    		, nAreaID = info.nAreaID}) )

			    result = self:routine(resp, REQUEST, function (event, msg, result)
			    	return self.handler.GET_ROOMS, self.resolve('ROOMS', {'nRoomCount', 'ROOM', data})
			    end)
				if result == false then break end
			end
			self.ready = true
			self:done()
		end
		MCClient:rpcall(TAG, proc)
	end
	local function proc( client )
		local _, resp, data, result
		-- 获取大厅版本
		REQUEST = mc.CHECK_VERSION
		local major, minor, buildno = config:getVersion()
		_, resp, data = client:syncSend(REQUEST
			, self:genDataREQ('VERSION_MB', {
				handler = self.fillCommonData,
				nMajorVer = major,
				nMinorVer = minor,
				nBuildNO = buildno,
				szExeName = config.target
				}) )
		result = self:routine(resp, REQUEST, function (event, msg, result)
			return self.handler.CHECK_VERSION, self.resolve('CHECK_VERSION_OK_MB', data)
		end)
		if result == false then return end

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
