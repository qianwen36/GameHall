local target = cc.load('form').build('BaseHall.interface')

cc.bind(target,	'event')

target.handler = {
	CONNECTION = 'CONNECTION',
	CHECK_VERSION= 'VERSION_MB',
	GET_SERVERS	= 'GET_SERVERS',
	GET_AREAS	= 'GET_AREAS',
	GET_ROOMS	= 'GET_ROOMS',
	HALL_READY	= 'READY',
	UPDATE_ROOMUSERSCOUNT = 'UPDATE_ROOMUSERSCOUNT'
}

function target:on(eventName, listener, tag)
	return self:addEventListener(eventName, listener, tag)
end

function target:isConnected()
	self:message(':isConnected()')
	return false
end
function target:body_resolve( body )-- resolve variant length array
	self:message(':body_resolve( body )')
end

function target:start( config )
	self:message(':start( config )')
end

function target:restart()
	self:message(':restart()')
end

function target:login()
	self:message(':login()')
end

function target:reqRoomsUserCount( param )-- param:room ids
	self:message(':reqRoomsUserCount( param )')
end

function target:reqServers( des, callack, notify )
	self:message(':reqServers( des, callack, notify )')
end

return target