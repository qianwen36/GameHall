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

function target:string( str, raw ) -- [raw = 'raw' or nil]
	self:definition(':string( str, raw )', 'required')
	return ''
end

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

function target:reqRoomsUserCount( param )-- param:room ids
	self:definition(':reqRoomsUserCount( param )')
end

function target:reqServers( des, callack, notify )
	self:definition(':reqServers( des, callack, notify )')
end

return target