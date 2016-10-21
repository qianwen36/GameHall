local target = cc.load('form').build('RoomSpace.interface', import('.BaseModel'))

-- event{name, body {event, msg, result}}
target.handler = {
	ONLINE_USERS = 'ONLINE_USERS',
}

function target:build( MainScene )
	self:definition(':build( MainScene )', 'required')
end

function target:onHallReady()
	self:definition(':onHallReady()')
end

return target