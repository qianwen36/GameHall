local Base = import('..BaseModel')
local target = cc.load('form').build('BaseHall.interface', Base)

-- event{name, body {event, msg, result}}
target.handler = {
	CHECK_VERSION= 'VERSION_MB',
	GET_SERVERS	= 'GET_SERVERS',
}

local TAG = 'Hall'
target.TAG = TAG
target.EVENT_CONNECTION = TAG..'.Connection'
target.status = {ready = false, connected = false}

function target:isConnected()
	self:definition(':isConnected()')
	return false
end
function target:body_resolve( value )-- resolve variant length array
	self:definition(':body_resolve( value )')
end

-- function target:getConfig( name ) -- override
-- 	Base.getConfig(self, name)
-- end

function target:start( config )
	self:definition(':start( config )')
end

function target:restart()
	self:definition(':restart()')
end

function target:reqServers( des, callack, notify )
	self:definition(':reqServers( des, callack, notify )')
end

return target