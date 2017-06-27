local function param_pack( params, callback )
	table.insert(params, callback)
	return params
end

local function future( ... )
	local order = {result = true}
	local function callback( ... )
		order.res = { ... }
		if order.co then
			coroutine.resume(order.co)
		end
	end
	function order:result()
		if (self.res == nil) then
			local co, main = coroutine.running()
			if not main then self.co = co else return end
			coroutine.yield()
		end
		return unpack(self.res)
	end
	local params = {...}
	local host, service = params[1], table.remove(params, 2)
	if type(params[#params]) == 'function' then
		params = table.remove(params)(params, callback)
	else
		params = param_pack(params, callback)
	end
	if type(host[service]) == 'function' then
		host[service](unpack(params))
		return order
	else
		print('service:'..service..' not implement at '..tostring(host))
	end
end
local function asyncall( ... )
	return future(...):result()
--[[
	local co, main = coroutine.running()
	if main then
		print('Please use .call(...) in .run(func) context')
		return
	end
	local function callback( ... )
		return coroutine.resume(co, ...)
	end
	local params = {...}
	local host, service = params[1], table.remove(params, 2)
	if type(params[#params]) == 'function' then
		params = table.remove(params)(params, callback)
	else
		params = param_pack(params, callback)
	end
	if type(host[service]) == 'function' then
		return coroutine.yield(host[service](unpack(params)))
	else
		print('service:'..service..' not implement at '..tostring(host))
	end
--]]
end

local function http(...)
	-- local order = http([method,] url [, params])
	-- status, resp = order:result()
	local method, url, params
	if select('#', ...) < 3 then
		method, url, params = 'GET', ...
	else
		method, url, params = ...
	end
	method = string.upper(method)
	local support = {GET = true, POST = true}
	if not support[method] then return end

	local request = cc.XMLHttpRequest:new()
	request:registerScriptHandler(function()
		local callback = request.callback
		if	callback then
			callback(request.status, request.responseText)
		end
	end)
	function request:script(params, callback)
		self.callback = callback
		self.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
		local handler = {}
		function handler.GET()
			self:open(method, url..'?'..params, true)
			self:send()
		end
		function handler.POST()
			self:open(method, url, true)
			self:setRequestHeader("Content-Type","application/x-www-form-urlencoded;")
			self:send(params)
		end
		if (handler[method]) then
			handler[method]()
		end
	end
	if params~=nil then
		local function url_encode(params)
			if type(params) ~= 'table' then
				return string.urlencode(tostring(params))
			end
			local pp = {}
			for k, v in pairs(params) do
				pp[#pp+1] = k..'='..string.urlencode(tostring(v))
			end
			return table.concat(pp, '&')
		end
		return future(request, 'script', url_encode(params))
	end
	return future(request, 'script')
end

local function runProcess( ... )
	local func = select(-1, ...)
	assert(type(func)=='function', 'the last argument must be a function for coroutine process')
	local co = coroutine.create(func)

	local function process( ... )
		coroutine.resume(co, ...)
	end
	process(...)
	return process
end

local target = {
	call = asyncall,
	book = future,
	http = http,
	run = runProcess
}

return target

--[[
-- example
local Plugin = plugin.AgentManager:getUserPlugin()
target.run(function ( ... )
	local code, msg, info = target.call(Plugin, 'queryThirdAccountBindState', 'weixin')
	if code == ThirdAccountStatus.kBinded then
		code, msg, info = target.call(Plugin, 'queryThirdInfo', 'weixin')
		if code == AsyncQueryStatus.kSuccess then
			dump(info)
		else
			print(msg)
		end
	end
	-- following using future model
	local order = target.http('http://huodong.uc108.org:922/CheckIn/AddCheckIn', {ActId=‘123’， UserId=77681})---
	local checkin = order
	order = target.http('http://huodong.uc108.org:922/floorreward/GetFloorRewardConfig', {actid='666'})
	local code, resp = order:result()
	code, resp = checkin:result()
end)

--]]
