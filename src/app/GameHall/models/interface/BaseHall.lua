local target = cc.load('form').build('BaseHall.interface', import('..BaseModel'))

-- event{name, body {event, msg, result}}
target.handler = {
	CONNECTION = 'CONNECTION',
	CHECK_VERSION= 'VERSION_MB',
	GET_SERVERS	= 'GET_SERVERS',
}

target.TAG = 'Hall'
target.ready = false

function target:isConnected()
	self:definition(':isConnected()')
	return false
end
function target:body_resolve( body )-- resolve variant length array
	self:definition(':body_resolve( body )')
end

function target:start( config )
	self:definition(':start( config )')
end

function target:restart()
	self:definition(':restart()')
end

function target:login()
	self:definition(':login()')
end

function target:reqServers( des, callack, notify )
	self:definition(':reqServers( des, callack, notify )')
end

return target