local target = cc.load('form').build('RoomSpace', import('.interface.RoomSpace'))

local DEFAULT_LEVEL = 2
function target:getConfig( ... )
	return self.app:getConfig('hall').config
end
function target:build( MainScene )
	self:reset()
	self.target = MainScene
	local MainScene_onEnter = MainScene.onEnter
	function MainScene:onEnter()
		MainScene_onEnter(self)
		local app = self:getApp()
	    target.app = app

	    local param = app:getConfig('hall')
	    local config = param.config
		local level = config.display_level or DEFAULT_LEVEL
	    if (config.display_level == nil) then
	    	config.display_level = level
	    end
	    self.param_ = param
	    self:test(param.offline, 1)
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
	function MainScene:test( offline, level, name )
		name = name or 'area'
		local array = {area = offline.areas, room = offline.rooms}
		array = array[name]
		if array==nil then return end
		local itemView = 'ItemView'
		local function handler( ... )
			local _, array = wrap2array(array)
			itemView = _ or itemView
			for i, item in ipairs(array) do
				item.name = name
				item.level = level
				self:addItem(item, itemView)
			end
			return self:showContent(level)
		end
		return handler()
	end
	function wrap2array( param )
		param = clone(param)
		local name = ''
		if type(param[1]) ~= 'table' then
			name = table.remove(param, 1)
		end
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
	function MainScene:showContent( level )
		local function vertialCenter( container )
			local size = container:getParent():getContentSize()
			container:align(cc.p(0, 0.5), 0, size.height/2)
			return container:show()
		end
		local handler = {
		function ()
			vertialCenter(self:layoutAreas())
			return self
		end,
		function()
			vertialCenter(self:layoutRooms())
			return self
		end
		}
		handler = handler[level]
		return handler and handler()
	end

	function MainScene:addItem(param, itemView )
		local container = {
			area = self.areasContainer,
			room = self.roomsContainer
		}
		container = container[param.name]
		local count = container:getChildrenCount()
		itemView = itemView or 'ItemView'
		local view = self:getContentView(itemView, param)
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
				print(self:getName()..':onItemClicked')
				return view.level and self:onItemClicked(view, param)
			end
			handler = handler[event.name]
			return handler and handler()
		end)
		view:addTo(button)
		view.level = param.level
		return view
	end

	function MainScene:onItemClicked( view, param )
		local handler = {
		function ( ... )
            local param = param.rooms
            if param == nil then return end
			local _, array = wrap2array(param)
			local level = 2
			for i,info in ipairs(array) do
				local param = target:roomParam(info, 'test')
				if param then self:addItem(param, 'ItemView2') end
			end
--			self:test(self:getApp():getConfig('hall').offline, 2, 'room')
			self:switchPanel('room')
			self:showContent(level)
		end,
		function ( ... )
			-- body
		end	}
		handler = handler[view.level]
		return handler and handler()
	end

	function MainScene:switchPanel( name )
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
    self.target:switchPanel('area')
end

function target:reset( ... )
	self.areas_ = {}
	self.rooms_ = {}
	self.onlineusers_param = nil
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

local function onlineCount( array )
	local c = 0
	for i,info in ipairs(array) do
		local online = info.online or 0
		c = c + online
	end
	return c
end

function target:onUpdateRoomUsersCount( event )
	local hall = self.hall
	if type(event) == 'table' then
		local array = hall:body_resolve(event.body)
		for i,info in ipairs(array) do
			info = info.data
			local room = self:getRoomById(info.nItemID) or {}
			local c = info.nUsers
			room.online = c
			self:log(':onUpdateRoomUsersCount( event )room.online='..c..'.'..hall:string(room.data.szRoomName))
		end
		array = self.areas_
		for i,info in ipairs(array) do
			info:update()
		end
	else -- timer
		local param = self:getOnlineParam()
		hall:reqRoomsUserCount(param, event)
	end
end

function target:getOnlineParam( ... )
	local param = self.onlineusers_param or {}
	if self.onlineusers_param == nil then
		local array = self.rooms_ or {}
		for i,info in ipairs(array) do
			info = info.data
			param[i] = info.nRoomID
		end
	end
	return param
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

function target:roomParam( info, option )
	option = option or 'formal'
	local handler = {formal = true, test = true}
	function handler.formal( ... )
		info = data
		local param = {name = 'room', level = 2}
		return param
	end
	function handler.test( ... )
		info.name = 'room'
		info.level = 2
		return info
	end
	handler = handler[option]
	return handler and handler()
end
function target:areaParam( info )
	info = info.data
	local hall = self.hall
	local backgrounds = {'gelou', 'leitai', 'two_pandas'}
	local param = {
		level = self:getConfig().display_level or DEFAULT_LEVEL,
		name = 'area',
		online = 0,
		background = backgrounds[info.nIconID],
		title = hall:string(info.szAreaName),
		rooms = self:getRooms(info.nAreaID),
		info = info
	}
	return param
end
function target:showContent( level, container )
	local MainScene = self.target
	local containers = {
		self.areasContainer,
		self.roomsContainer
	}
	level = level or 1
	container = container or containers[level]
	MainScene.cleanContainer(container)
	assert(level>0)
	local handler = {
	function ( ... )
		local array = self.areas_ or {}
		for i,info in ipairs(array) do
			local param = self:areaParam(info)
			param.index = i
			local view = MainScene:addItem(param, level, 'area')
			info.view = view
			function info:update( ... )
				local c = onlineCount(self.rooms)
				self.online = c
				self.view:onlineUsers(c)
			end
		end
		MainScene:showContent('area')
	    self:onUpdateRoomUsersCount('start')
	    self.timer = MainScene:getScheduler():scheduleScriptFunc(handler(target, target.onUpdateRoomUsersCount), 30, false)
	end,
	function ( ... )
	end
	}
end

return target
