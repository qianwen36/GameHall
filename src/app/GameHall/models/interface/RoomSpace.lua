local target = cc.load('form').build('RoomSpace.interface', import('.HallSpread'))

-- event{name, body {event, msg, result}}
target.handler = {
	ONLINE_USERS = 'ONLINE_USERS',
}

function target:build( MainScene )
	self:definition(':build( MainScene )', 'required')
end

return target