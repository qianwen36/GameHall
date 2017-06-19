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
		local params = {...}
		table.insert(params, 1, co)
		return coroutine.resume(unpack(params))
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

local function runProcess( func, ... )
	local co = coroutine.create(func)

	local params = {...}
	table.insert(params, 1, co)
	return coroutine.resume(unpack(params))
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
