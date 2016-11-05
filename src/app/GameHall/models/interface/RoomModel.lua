local target = cc.load('form').build('RoomModel.interface', import('.HallSpread'))

local TAG = 'Room'
target.TAG = TAG
target.EVENT_CONNECTION = TAG..'.Connection'

target.HALL_READY = 'HALL_READY'
target.ROOM_READY = 'ROOM_READY'
-- event{name, value {event, msg, result}}
target.handler = {
	ONLINE_USERS_UPDATE = 'ONLINE_USERS_UPDATE',
	ENTER_ROOM = 'ENTER_ROOM',
	LEAVE_ROOM = 'LEAVE_ROOM',
	NEED_UPRAGE = 'NEED_UPRAGE',
}
target.status = {ready = false, connected = false, entering = false}

function target:reset()
	self:spec('areas', {})
	self:spec('rooms', {})
end

function target:quit(param)
	self:definition(':quit(param)')
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

function target:enterRoom( info ) -- roominfo
	self:definition(':enterRoom( info )')
	-- connect the room server
	-- enter room
	-- get a table
end

function target:updateOnlineusers( param, interval )-- param:[room, ...], register and init event dispatcher
	self:definition(':updateOnlineusers( param, interval )')
end

return target