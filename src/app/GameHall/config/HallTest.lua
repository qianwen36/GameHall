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
		type = 'deposit',
		name = '测试',
		condition = 100,
		online = 15,
		activity = ''
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
					local room = rooms2[v]
					if rooms2 == nil then
						t[i] = rooms
					elseif room~=nil then
						if type(room)=='table'and next(room) then
							v = clone(room)
						else
							v = {room}
						end
						v.area = area
						t[i] = v
					end
				end
				if rooms2==nil then break end
				table.insert(t, 1, cls)

			elseif area.rooms and next(area.rooms)~=nil then
				area.rooms = rooms
			end
		end
	end
end
init(config.areas, config.rooms)

return config