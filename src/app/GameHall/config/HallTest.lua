local config = {
	areas = {'AreaView',
	{
		condition = '100两以上',
		online = '65',
		background = 'leitai',
		title = 'dadetong',
		rooms = {1}
	},
	{
		condition = '100两以上',
		online = '35',
		background = 'gelou',
		title = 'guandimiao'
	},
	{
		condition = '200两以上',
		online = '20',
		background = 'two_pandas',
		title = 'baiyinggu'
	},
	},
	rooms = {'RoomView',
	{
	}
	}
}
local function init( areas, rooms )
	if type(areas[2])~='table'then
		areas.rooms = rooms
	else
		for i = 2, #areas do
			area = areas[i]
			local cls = rooms[1]
			local rooms2 = rooms[2]
			if type(rooms2)=='table' then
				local t = area.rooms or {}
				for i,v in ipairs(t) do
					local room = rooms2[v] or {}
					v = (next(room) and clone(room)) or room
					v.area = area
					table.insert(v, 1, cls)
					t[i] = v
				end
			else
				area.rooms = {rooms}
			end
		end
	end
end
init(config.areas, config.rooms)

return config