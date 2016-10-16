local target = {}
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

target.handler = {
	CONNECTED = 'CONNECTED',
	CHECK_VERSION = 'VERSION_MB',
	GET_SERVERS = 'GET_SERVERS',
	GET_AREAS = 'GET_AREAS',
	GET_ROOMS = 'GET_ROOMS',
}

function target:start( ... )
end

return target
