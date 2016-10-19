local target = cc.load('form').build('RoomSpace', import('.interface.RoomSpace'))
function target:build( MainScene )
	self:reset()
	self.target = MainScene
	local MainScene_onEnter = MainScene.onEnter
	function MainScene:onEnter()
		MainScene_onEnter(self)
	    local param = self:getApp():getConfig('hall')
	    self.param_ = param
	    self:test('area', param.offline.areas)
	    local model = self:getApp():model('BaseHall')
	    model:on(model.handler.GET_AREAS, handler(target, target.onGetAreas))
	    model:on(model.handler.GET_ROOMS, handler(target, target.onGetRooms))
	    model:on(model.handler.CONNECTION, handler(target, target.onConnection))
	    model:on(model.handler.UPDATE_ROOMUSERSCOUNT, handler(target,target.onUpdateRoomUsersCount))
	    target.hall = model
	end

	function MainScene:getContentView( name, param )
		local path = self.param_[1] or 'src.app.GameHall.views.content'
		local view = require(path..'.'..name):create(self:getApp(), name, param)
		return view
	end

	local wrap2array
	function MainScene:test( test, param )
		if param==nil then return end
		test = test or 'area'
		local function handler( ... )
			local name, array = wrap2array(param)
			for i, item in ipairs(array) do
				self:addItem(name, item)
			end
			return self:showContent(test)
		end
		return handler()
	end
	function wrap2array( param )
		param = clone(param)
		local name = table.remove(param, 1)
		if #param ==0 then
			param = {param}
		end
		return name, param
	end

	function MainScene:layoutAreas(  )
		local container = self.areasContainer
		local x, y, c
		if c == 0 then return container end

		local item = container:getChildByTag(1)
		local size = container:getContentSize()
		c = container:getChildrenCount()
		x = 0
		y = size.height/2
		local function layout( d, dw )
			dw = dw or 0
			for i=1, c do
				x = x + d + dw
				if i == 1 then
					dw = dw * 2
					x = x - dw * 2
				end
				container:getChildByTag(i):move(x, y)
			end
			local size = item:getContentSize()
			local width = x + (size.width+dw)/2
--			if c < 4 then
--				local x = item:getPositionX()-size.width/2
--				width = width - x
--			end
			return cc.size(width, size.height)
		end
		if c <= 4 then
			size = layout(size.width/(c+1))
		else
			local c = 4
			local width = item:getContentSize().width
			local d = size.width/(c+1)
			local dw = (d - (width/2))/c
			size = layout(d , dw)
		end
		container:getInnerContainer()
			:setContentSize(size)
		return container
	end
	function MainScene:layoutRooms(  )
		local container = self.roomsContainer
		local c = container:getChildrenCount()
		local size = container:getContentSize()
		if c == 0 then return container end
		local item = container:getChildByTag(1)
		if c == 1 then
			item:move(size.width/2, size.height/2)
		else
			local x = size.width/4
			local y = size.height/2
			local item = container:getChildByTag(i)
			for i=1, c do
				if (i > 4) then
					local p = {x=0,y=0}
					if (i % 2 ~= 0) then
						p.x = x + size.width/2
					else
						p.x = size.width/4
					end
					local d = math.floor(i/2)
					p.y = y + d * (size.height/2)
					item:move(x, y)
					x, y = p.x, p.y
				else
					item:hide()		
				end
			end
		end
		return container
	end
	function MainScene:showContent( name )
		local handler = {}
		local function vertialCenter( container )
			local size = container:getParent():getContentSize()
			container:align(cc.p(0, 0.5), 0, size.height/2)
			return container:show()
		end
		function handler.area()
			vertialCenter(self:layoutAreas())
			return self
		end
		function handler.room(  )
			vertialCenter(self:layoutRooms())
			return self
		end
		handler = handler[name]
		return handler and handler()
	end

	function MainScene:addItem( name, param )
		local container = {
			ItemView = self.areasContainer,
			ItemView2 = self.roomsContainer
		}
		container = container[name]
		local count = container:getChildrenCount()
		name = name or 'ItemView'
		local view = self:getContentView(name, param)
		local button = view:getButton()
			:removeSelf()
			:addTo(container)
			:setTag(count+1)
		local y = container:getContentSize().height/2
		local size = button:getContentSize()
		if count >0 then
			local node = container:getChildByTag(count)
			local pos = cc.p(node:getPositionX(), node:getPositionY() + size.width/2)
			button:move(pos.x, y)
		else
			button:move(size.width/2, y)
		end
		button:onTouch(function ( event )
			local handler = {}
			function handler.ended()
				local type = {ItemView = 'area', ItemView2 = 'room'}
				type = type[name]
				return type and self:onItemClicked(view, type, param)
			end
			handler = handler[event.name]
			return handler and handler()
		end)
		return view
	end

	function MainScene:onItemClicked( view , type, param )
		local handler = {}
		function handler.room( ... )
		end
		function handler.area( ... )
			self:switchContent('room')
			self:test('room', param.rooms)
		end
		handler = handler[type]
		return handler and handler()
	end

	function MainScene:switchContent( name )
		local handler = {}
		function handler.room( ... )
			self.areasContainer:hide()
			self.roomsContainer:show()
			self.btnHead:hide()
			self.btnBack:show()
		end
		function handler.area( ... )
			self.btnHead:show()
			self.btnBack:hide()
			self.roomsContainer:hide()
			self.areasContainer:show()
	        self.cleanContainer(self.roomsContainer)
		end
		handler = handler[name]
		return handler and handler()
	end

	function MainScene.cleanContainer(container)
        local c = container:getChildrenCount()
	    for i = 1, c do
	        container:getChildByTag(i):hide():removeSelf()
	    end
	end
end

function target:goBack(...)
    self.target:switchContent('area')
end

function target:reset( ... )
	self.areas_ = {}
	self.rooms_ = {}
	self.views_ = {}
	local timer = self.timer
	self.timer = timer and self.target:getScheduler():unscheduleScriptEntry(timer)
end

function target:onGetAreas( event )
	local array = self.hall:body_resolve(event.body)
	for i,info in ipairs(array) do
		info.rooms = {}
	end
	self.areas_ = array
end
function target:onGetRooms( event )
	local array = self.hall:body_resolve(event.body)
	if array ~= nil then
		for i,info in ipairs(array) do
			local area = self:getAreaById(info.data.nAreaID)
			info.area = area
			table.insert(area.rooms, info)
		end
		local rooms = self.rooms_
		table.insertto(rooms, array, #rooms+1)
	else -- failed
	end
end

function target:onConnection( event )
	if not self.hall:isConnected() then
		self:reset()
	end
end

function target:onUpdateRoomUsersCount( event )
	local hall = self.hall
	if type(event) == 'table' then
		local array = hall:body_resolve(body)
		for i,info in ipairs(array) do
			local room = self:getRoomById(info.nItemID) or {}
			room.online = info.nUsers
			self:log(':onUpdateRoomUsersCount( event )'..hall:string(room.data.szRoomName))
		end
		array = self.areas_
		for i,info in ipairs(array) do
			local c = onlineCount(info.rooms)
			info.online = c
			local view = self:getAreaView(i)
			if view then view:setOnline(c) end
		end
	else -- timer
		local param = {}
		local array = self.rooms_ or {}
		for i,info in ipairs(array) do
			param[i] = info.nRoomID
		end
		hall:reqRoomsUserCount(param)
	end
end

function target:getAreaView( index )
	return self.views('area')[index]
end
function target:getRoomView( index )
	return self.views('room')[index]
end
function target:getArea( index )
	local array = self.areas_ or {}
	return array[index]	
end
function target:getAreaById( id )
	return self:resolve_info(id, 'areas_', 'nAreaID')
end

function target:getRoom( index )
	local array = self.rooms_ or {}
	return array[index]	
end
function target:getRoomById( id )
	return self:resolve_info(id, 'rooms_', 'nRoomID')
end

function target:resolve_info( value, name, field )
	local array = self[name] or {}
	for i,info in ipairs(array) do
		if info.data[field] == value then
			return info
		end
	end
end

function target:getRooms( nAreaID )
	local res = {}
	local array = self.rooms_ or {}
	for i,info in ipairs(array) do
		if info.nAreaID == nAreaID then
			table.insert(res, info)
		end
	end
	return res
end

function target:views( name )
	local array = self.views_[name] or {}
	return array
end

function target:areaParam( info )
	local data = info.data
	local param = {
		name = self.hall:string(data.szAreaName),
		online = 0,
		background = '',
		title = '',
		rooms = self:getRooms(data.nAreaID),
	}
	return param
end
function target:showContent( container )
	local MainScene = self.target
	MainScene.cleanContainer(container)
	local array = self.areas_ or {}
	local views = self:views('area')
	for i,info in ipairs(array) do
		local param = self:areaParam(info)
		param.index = i
		local v = MainScene:addItem('ItemView', param)
		table.insert(views, v)
	end
	MainScene:showContent('area')
    self:onUpdateRoomUsersCount()
    self.timer = MainScene:getScheduler():scheduleScriptFunc(handler(target, target.onUpdateRoomUsersCount), 30, false)
end

return target
