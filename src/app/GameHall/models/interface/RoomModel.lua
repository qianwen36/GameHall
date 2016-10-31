local target = cc.load('form').build('RoomModel.interface', import('.HallSpread'))

-- event{name, body {event, msg, result}}
target.handler = {
	ONLINE_USERS_UPDATE = 'ONLINE_USERS_UPDATE'
}

function target:reset()
	self:spec('areas', {})
	self:spec('rooms', {})
end

function target:roominfo( id )
	self:definition(':roominfo( id )')
--[[	return {
		id = id,
		name = '',
		type = 0,
		subtype = 0,
		icon = 0,
		status = 0,
		layorder = 0,
		fontcolor = 0,
		gift = 0,
		condition = 0,
		}]]
end
function target:areainfo( id )
	self:definition(':areainfo( id )')
--[[	return {
		id = id,
		name = '',
		type = 0,
		subtype = 0,
		icon = 0,
		status = 0,
		layorder = 0,
		fontcolor = 0,
		gift = 0,
		}]]
end

function target:updateOnlineusers( param, interval )-- param:[room, ...], register and init event dispatcher
	self:definition(':updateOnlineusers( param, interval )')
end

return target