local MCAgent = MCAgent:getInstance()
local Scheduler = cc.Director:getInstance():getScheduler()
local target = {
	_client = {},
	TIMEOUT = 3,
--	_routes = {}
}
local mc = {
    UR_SOCKET_CLOSE     =1,
	UR_SOCKET_ERROR		=2,
	UR_SOCKET_CONNECT	=3,
	UR_SOCKET_GRACEFULLY_ERROR = 4,
	UR_REQUEST_UNKNOWN	=10000,
	UR_INVALID_PARAM	=1011,
	UR_RESPONSE_TIMEOUT	=1030,
	UR_CONNECT_DISABLE	=1031,
	UR_RECONNECT_SVR	=1040,
	UR_OPERATE_SUCCEED	=10,
	UR_OPERATE_FAIL		=10100, 
}
local mType = {MSG_REQUEST=1, MSG_RESPONSE=2}

function target:describe(respondId) -- 请求超时
    local text = {
    [mc.UR_SOCKET_CLOSE]    = "Sockeet Close",
	[mc.UR_SOCKET_ERROR]	= "Socket Error",
	[mc.UR_SOCKET_CONNECT]	= "Socket Connected",
	[mc.UR_SOCKET_GRACEFULLY_ERROR] = "Connection Gracefully Error",
	[mc.UR_REQUEST_UNKNOWN]	= "unknown request",
	[mc.UR_INVALID_PARAM]   = "Invalid parameter",
	[mc.UR_RESPONSE_TIMEOUT]= "Response timeout",
	[mc.UR_CONNECT_DISABLE]	= "Connection disable",
	[mc.UR_RECONNECT_SVR]	= "Server reconnected",
	[mc.UR_OPERATE_SUCCEED]	= "Operation Success",
	[mc.UR_OPERATE_FAIL]	= "Operation Failed" 
    }
    return tostring(text[respondId])
end

function target:accept(respondId) -- only should be UR_OPERATE_SUCCEED or XX_SUCCEED
	return respondId == mc.UR_OPERATE_SUCCEED
end
function target:isConnected(respondId)
	return respondId == mc.UR_SOCKET_CONNECT
end

function mc.brokenSession( respondId )-- 连接异常
	local c = {
		mc.UR_RESPONSE_TIMEOUT,
		mc.UR_SOCKET_ERROR,
		mc.UR_SOCKET_GRACEFULLY_ERROR,
		mc.UR_CONNECT_DISABLE
	}
	local res = false
	for i=1, #c do
		res = (c == respondId)
		if res then break end
	end
	return res
end
function mc.filterNetwork(respondId)
	local c = {
		mc.UR_RESPONSE_TIMEOUT,
		mc.UR_SOCKET_ERROR,
		mc.UR_SOCKET_CONNECT,
		mc.UR_SOCKET_GRACEFULLY_ERROR,
		mc.UR_CONNECT_DISABLE,
		mc.UR_RECONNECT_SVR
	}
	local res = false
	for i=1, #c do
		res = (c[i] == respondId)
		if res then break end
	end
	return res
end

function mc.isResponse(msgType)
	return msgType == mType.MSG_RESPONSE
end

local function onDataNotify(client, clientId, msgType, sessionId, respondId, data)
	-- 连接通知	client._onConnection
	-- 系统通知	client:response(respondId)
	-- 请求应答 client:session()
	local function handlerResponse( client, session, respondId, data )
		if session then
			local callback = session.callback
			local timer = session.timer
			if timer ~= nil then Scheduler:unscheduleScriptEntry(timer) end
			if callback ~= nil then callback(client, respondId, data) end
			client:dropSession()
		end
	end
	if mc.isResponse(msgType) then
		local session = client:session()
        local original = session and session.session
		if original == sessionId then
			handlerResponse(client, session, respondId, data)
		else
			print('client['..clientId..'].session('..sessionId..') no handle')
		end
	elseif mc.filterNetwork(respondId) then
        if mc.brokenSession(respondId) then -- should notify the request caller
		    handlerResponse(client, client:session(), respondId, data)
        end
		local callback = client._onConnection
        return callback and callback(client, respondId)
	else
		local callback = client:response(respondId)
		if callback ~= nil then callback(client, respondId, data) end
	end
	client:next() -- request from queue 
end

function target:connect( host, port, tag, callback )-- function callback(client, respondId) end
	if type(tag) ~= 'string' then return end
	if type(callback)~= 'function' then return end

	local client = MCAgent:createClient(host, port)
--[[
	[MCClient::]
	setCallback(
		function(clientId, msgType, sessionId, respondId, data)	end)
	connect(host, port)
	disconnect()
	reconnection()
	sendRequest(requestId, data, datalen, isWaiting)
	destroy()
--]]
	self:build(client, tag, callback):connect()
	return client
end
function target:build(client, tag, onConnection)
	function client:_init(onConnection)
        local function fnCallback(clientId, msgType, sessionId, respondId, data)
            onDataNotify(self, clientId, msgType, sessionId, respondId, data)
        end
		self._response = {}
		self._session = {}
		self._quene = {}
		self:onConnection(onConnection)
			:setCallback(fnCallback)
	end
	function client:onConnection(onConnection)
		self._onConnection = onConnection
		return self
	end
	function client:response(respondId)
		local response = self._response
		if respondId ~= nil then return response[respondId] end
		
		return response
	end
	function client:on( respondId, callback) --[[function(client, respondId, data) end]]
		local response = self:response()
		response[respondId] = callback
		return self
	end
	function client:off( respondId )
		local response = self:response()
		response[respondId] = nil
		return self
	end
	function client:session()
		local session = self._session
		return session[session._REQid]
	end
	function client:keepSession( sessionid, requestid, callback, timeout )
		local session = self._session
		local timer = timeout and
		Scheduler:scheduleScriptFunc(function ()
			Scheduler:unscheduleScriptEntry(session[sessionid].timer)
			onDataNotify(self, -1, mType.MSG_RESPONSE, sessionid, mc.UR_RESPONSE_TIMEOUT, "time out")
		end, timeout, false)
		session[sessionid] = 
		{
			session = sessionid,
			request = requestid,
			callback= callback,
			timer = timer
		}
		session._REQid = sessionid
	end
	function client:dropSession()
		local session = self._session
		session[session._REQid] = nil
		session._REQid = nil
	end
	function client:queue(...)
        local param = {...}
		local quene = self._quene
        if #param == 0 then
			return table.remove(quene, 1)
		else
            table.insert(quene, param)
		end
		return self
	end
	function client:send(requestid, data, callback, timeout) --[[function(client, respondId, data) end]]
		if self:session() ~= nil then
			return self:queue(requestid, data, callback, timeout)
		end
		local echo = (timeout and true ) or false
        local sessionid = self:sendRequest(requestid, data, data:len(), echo)
		self:keepSession(sessionid, requestid, callback, timeout or target.TIMEOUT)
		return self
	end
	function client:next()
		local params = self:queue()
		return params and self:send(unpack(params))
	end

	function client:reset() -- reset the requests queue
		self._quene = {}
		self._session = {}
	end
	
	local client_destroy = client.destroy
	function client:destroy()
		self._onConnection = nil
		self._response = nil
		self._session = nil
		self._quene = nil
		client_destroy(self)
	end
	local client_disconnect = client.disconnect
	function client:disconnect()
		self:reset()
		client_disconnect(self)
	end
	local client_reconnection = client.reconnection
	function client:reconnection()
		self:reset()
		client_reconnection(self)
	end

	client:_init(onConnection)

	self._client[tag] = client
	self[tag] = {host, port}
	return client
end
function target:client(tag)
	return self._client[tag]
end
function target:disconnect(tag)
	self:client(tag):disconnect()
end
function target:reconnection(tag)
	self:client(tag):reconnection()
end
function target:onConnection(tag, callback)
	self:client(tag):onConnection(callback)
end
function target:destroy(tag)
	if tag ~=nil then
		local client = self:client(tag)
		print("client("..tag.."):destroy")
		self._client[tag] = nil
		client:destroy()
	end
	-- destroy all MCClient instance
	for tag, client in pairs(self._client) do
		print("client("..tag.."):destroy")
		client:destroy()
	end
	self._client = {}
end

-- RPC on server, so that we can write synchronizing script for interaction
function target:rpcall( tag, proc )	--[[function proc( client )	end]]
	local client = self:client(tag)
	if client == nil then
		print('target:rpcall('..tag..') <= client not exist')
		print('Please do target:connect(host, port, callback) before')
		return self
	end
	local context = {fun = proc}
    context.coro = coroutine.create( function()
        local status, msg = xpcall(proc
        , __G__TRACKBACK__, client)
        if not status then print(msg) end
        client.syncSend = nil --remove
	    print('coroutine['..tostring(context.coro)..'].end')
	    return msg
    end )

	function context:callback (...)
		local params = self.params
		if type(params) =='table' then
		    params.response = {...}
		    local status, msg = xpcall(self.switch
		    , __G__TRACKBACK__, self)
		    if not status then print(msg) end
		else
		    print('context:callback(client)##params = '..tostring(params))
		end
	end
    
    function context:switch()
	    local code, params = coroutine.resume(self.coro)
	    print('coroutine['..tostring(self.coro)..'].status: ' .. coroutine.status(self.coro))
	    if type(params) =='table'
	    and params.client~=nil then
	        local requestId, data = unpack(params[1])
            local function onResponse(...)
                self:callback(...)
            end
	        params.client:send(
	        	requestId, data,
	        	onResponse, target.TIMEOUT)
	    end
	    self.params = params
	    return params
    end

    function context.send(client, requestId, data )
	    local params = {{requestId, data}, client = client, response = nil}
	    coroutine.yield(params)
	    return unpack(params.response)
    end
    function context:wrapper(client)
		client.syncSend = self.send -- mount a method
	    return self
    end
    return context:wrapper(client):switch()
end
------------------------------------------------------------------------------
local ffi = require('ffi')
local utils = {}
-- VLA — A variable-length array
function utils.vla_resolve(ctype, c, data)
    if c > 0 then
	    local vla = ctype..'[?]'
	    local ct = ffi.new(vla, c)
	    ffi.copy(ct, data, data:len())
	    return ct
    end
end
-- VLS — A variable-length struct is a struct C type where the last element is a VLA. 
function utils.vls_resolve(ctype, data)
	local offset  = ffi.sizeof(ctype)
	local body = string.sub(data, offset+1)
	local ct = ffi.new(ctype)
	ffi.copy(ct, data, offset)
--	print('['..ctype..'].size = '.. offset..', data.len ='.. data:len())
	return ct, body
end
-- ct — A C type specification
function utils.ct_resolve(ctype, data)
	local ct = ffi.new(ctype)
	ffi.copy(ct, data, data:len())
	return ct
end

local utils_assign -- function(ct, des)
local utils_fill -- function(ct, des)
function utils_assign(ct, des)
	if type(des)== 'table' then
		utils_fill(ct, des)
	elseif type(des)== 'string' then
		ffi.copy(ct, des)
	elseif type(des)~= 'nil' then
		ct = des
	else
		print('utils_assign()#des='..tostring(des))
	end
	return ct
end
function utils_fill( ct, des )
	for k,v in pairs(des) do
		local ct2 = ct[k]
		if ct2 ~= nil then
			local t = type(v)
			if t == 'string'
			or t == 'table' then
				utils_assign(ct2, v)
			else
				ct[k] = v
			end
		else
			print('utils_fill()#'..tostring(ct)..'.'..k..' key not exist')
		end
	end
	return ct
end
function utils.ct_generate( ctype, des )
	local ct = ffi.new(ctype)
	local data = ffi.string( utils_assign(ct, des), ffi.sizeof(ctype) )
	return data, ct
end

function utils.vls_generate( chead, ctype, des )
	local list = table.remove(des)
	if type(list) ~= 'table' then return end
	local head = utils.ct_generate(chead, des)
	local c = #list
	local ct = ffi.new(ctype..'[?]', c)
	for i=1, c do
		utils_assign(ct[i-1], list[i])
	end
	local body = ffi.string(ct, ffi.sizeof(ctype, c))
	return head..body
end

target.utils = utils
------------------------------------------------------------------------------
--[[
-- example of target
local TAG = 'Hall'
local client = target:connect('192.168.1.222', '31626'
	, TAG, function (client, resp)
		print(TAG..'response('..resp..')')
	end)
local hClient = target:client(TAG) -- hClient == client
-- requestid, data; using ffi to index data
hClient:send(mc.CHECK_VERSION,
utils.ct_generate('VERSION_MB',{
		nMajorVer = 2,
		nMinorVer = 1,
		nBuildNO = 20130822,
		nGameID = 234,
		szExeName = 'AND'
	}),
function(client, resp, data)
    if target:accept(resp) then
    	local t = utils.ct_resolve('CHECK_VERSION_OK_MB', data)
	    print('[CHECK_VERSION_OK_MB]')
	    print('nMajorVer ='..t.nMajorVer)
	    print('nMinorVer ='..t.nMinorVer)
	    print('nBuildNO ='..t.nBuildNO)
	    print('nCheckReturn ='..t.nCheckReturn)
	    print('szDLFile ='..ffi.string(t.szDLFile))
	    print('szUpdateWWW ='..ffi.string(t.szUpdateWWW))
	    print('dwClientIP ='..t.dwClientIP)
    else
        print(TAG..".TEST:"..target:describe(resp))
    end
end)
target:rpcall(TAG, function (client)
	-- synchronizing script for interaction to server
	local _, resp, data
	local function routine( proc )
		if MCClient:accept(resp) then
			proc()
		else
		    print(TAG..".TEST:"..MCClient:describe(resp))
		end
	end
	_, resp, data = client:syncSend(mc.GET_AREAS, utils.ct_generate('GET_AREAS'))
	_, resp, data = client:syncSend(mc.GET_ROOMS, utils.ct_generate('GET_ROOMS'))
	---
end)
--hClient:disconnect()
--hClient:reconnection()
target:disconnect(Hall)
target:reconnection(Hall)
target:destroy(Hall)
--]]
return target