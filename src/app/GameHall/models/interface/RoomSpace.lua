local target = cc.load('form').build('RoomSpace.interface')

cc.bind(target, 'event')
-- event{name, body {event, msg, result}}
target.handler = {
	ONLINE_USERS = 'ONLINE_USERS',
}

function target:on(eventName, listener, tag)
	return self:addEventListener(eventName, listener, tag)
end

function target:off( tag )
	return self:removeEventListenersByTag(tag)
end

function target:build( MainScene )
	self:definition(':build( MainScene )', 'required')
end

function target:showContent()
	self:definition(':showContent( container )')
end

return target