local function param_pack( params, callback )
	table.insert(params, callback)
	return params
end

local function asyncall( ... )
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
	run = runProcess
}

return target

--[[
-- example
local Plugin = plugin.AgentManager:getUserPlugin()
target.run(function ( ... )
	local code, msg, info = target.call(Plugin, 'queryThirdInfo', 'weixin')
	if code == AsyncQueryStatus.kSuccess then
		dump(info)
	else
		print(msg)
	end
	code, msg = target.call(Plugin, 'queryThirdAccountBindState', 'weixin')
end)

--]]
