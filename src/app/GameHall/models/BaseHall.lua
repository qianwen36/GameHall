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
	local utils = HslUtils:create(config.abbr) -- safe, once create
	self.config_ = config
	self.hslUtils = utils
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
			self:nextSchedule(self.initHall, config)
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

function target:initHall(config)
	local REQUEST, reqData -- request id

	local co
	local function onGetServersOK( _, resp, data )
		coroutine.resume(co, _, resp, data)
	end
	local function proc( client )
		local _, resp, data, result
		-- 获取大厅版本
		REQUEST = mc.CHECK_VERSION
		local major, minor, buildno = config:getVersion()
		reqData = self:genDataREQ('VERSION_MB', {
				handler = self.fillCommonData,
				nMajorVer = major,
				nMinorVer = minor,
				nBuildNO = buildno,
				szExeName = config.target
				})
		_, resp, data = client:syncSend(REQUEST, reqData )
		result = self:routine(resp, REQUEST, function (event, msg, result)
			return self.handler.CHECK_VERSION, self.resolve('CHECK_VERSION_OK_MB', data)
		end)
		if result == false then return end

		-- 获取大厅服务器
		REQUEST = mc.GET_SERVERS
		local notify = DEBUG~=0

		reqData = self:genDataREQ('GET_SERVERS', {
			handler = self.fillCommonData,
			nServerType = desc.nServerType or mc.ext.SERVER_TYPE_HALL,
			dwGetFlags = (notify and mc.Flags.FLAG_GETSERVERS_NOTIFY) or 0
		})
		if notify then
			client:once(mc.GET_SERVERS_OK, onGetServersOK)
			client:send(REQUEST, reqData)
			_, resp, data = coroutine.yield()
		else
			_, resp, data = client:syncSend(REQUEST, reqData )
		end
		result = self:routine(resp, {REQUEST, mc.GET_SERVERS_OK}, function (event, msg, result)
			return self.handler.GET_SERVERS, self.resolve('SERVERS', {'nServerCount', 'SERVER', data})
		end)
		if result == false then return end
		self.ready = true
		self.hslUtils:saveHallSvr(data, data:len())
		self:done()
	end
	co = MCClient:rpcall(TAG, proc)
	self:log(':initHall(config).done')
end

return target
