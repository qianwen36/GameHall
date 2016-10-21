local target = cc.load('form').build('RoomSpace', import('.interface.RoomSpace'))
local mc = import('..comm.HallDef')

local DEFAULT_LEVEL = 2
local DEFAULT_INTERVAL = 60
local wrap2array -- funtion(param)
function target:getConfig( ... )
	return self.app:getConfig('hall').config
end
function target:build( MainScene )
	self.target = MainScene
	if not self.ready then
		self:reset()
	end

	local TAG = {
		CONNECTION = 'ONCONNECTION',
		GET_AREAS = 'GET_AREAS',
		GET_ROOMS = 'GET_ROOMS',
		UPDATE_ROOMUSERSCOUNT = 'UPDATE_ROOMUSERSCOUNT'
	}
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
	    if (target.config == nil) then
	    	target.config = config
	    end
	    self.param_ = param
	    self:test(param.offline, 1)
	    local hall = target.hall or self:getApp():model('BaseHall')
	    hall:on(hall.handler.GET_AREAS, handler(target, target.onGetAreas), TAG.GET_AREAS)
	    hall:on(hall.handler.GET_ROOMS, handler(target, target.onGetRooms), TAG.GET_ROOMS)
	    hall:on(hall.handler.CONNECTION, handler(target, target.onConnection), TAG.CONNECTION)
	    hall:on(hall.handler.UPDATE_ROOMUSERSCOUNT,
	    	handler(target,target.onUpdateRoomUsersCount), TAG.UPDATE_ROOMUSERSCOUNT)
	    if (target.hall==nil) then 
			target.hall = hall
		end
		local params = target.params
		if params ~= nil then
			if type(params)~='table' then params = {params} end
			target:showContent(params[1], nil, params[2])
		end
	end
	local MainScene_onExit = MainScene.onExit
	function MainScene:onExit()
		MainScene_onExit(self)
		local hall = target.hall
		hall:off(TAG.GET_AREAS)
		hall:off(TAG.GET_ROOMS)
		hall:off(TAG.UPDATE_ROOMUSERSCOUNT)
		target:stopOnlineUsersTimer()
	end

	function MainScene:getContentView( name, param )
		local path = self.param_[1] or 'src.app.GameHall.views.content'
		local view = require(path..'.'..name):create(self:getApp(), name, param)
		return view
	end

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
			return self:layoutContent(level)
		end
		return handler()
	end

	function MainScene:layoutMainLinear(  )
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
	local function buildPosGrid4( cSize, iSize )
		local array = {1, 2, 3, 4}
		array[1] = {cc.p(cSize.width/2, cSize.height/2)}
		local ar = {}
		local width = iSize.width
		local height = iSize.height
		local d = (cSize.width/2 - width)/2
		local orgX = iSize.width/2 + d
		local x = orgX
		local y = cSize.height/2
		for i=1,2 do
			ar[i] = cc.p(x, y)
			x = x + width + d*2
		end
		array[2] = ar
		ar = {}
		local dy = (cSize.height/2 - height)/2
		y = height/2 + d
		x = orgX
		for i=1,2 do
			ar[i] = cc.p(x, y)
			x = x + width + d*2
		end
		y = y + height + dy*2
		x = orgX
		for i=3,4 do
			ar[i] = ar[i-2]
			ar[i-2] = cc.p(x, y)
			x = x + width + d*2
		end
		array[3] = ar
		array[4] = ar
		return array
	end
	function MainScene:layoutRoomGrid(  )
		local container = self.roomsContainer
		local c = container:getChildrenCount()
		local size = container:getContentSize()
		if c == 0 then return container end
		local item = container:getChildByTag(1)
		local array = buildPosGrid4(size, item:getContentSize())
		local pos = array[c]
		for i=1,c do
			local pos_ = pos and pos[i]
			local item = container:getChildByTag(i)
			if pos_== nil or i > 4 then
				item:hide()
			else
				item:move(pos_)
			end
		end
		return container
	end
	function MainScene:layoutContent( level )
		local function vertialCenter( container )
			local size = container:getParent():getContentSize()
			container:align(cc.p(0, 0.5), 0, size.height/2)
			return container:show()
		end
		local handler = {
		function ()
			vertialCenter(self:layoutMainLinear())
			return self
		end,
		function()
			vertialCenter(self:layoutRoomGrid())
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
				self:log(':onItemClicked')
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
			target:showContent(view.level+1, self.roomsContainer, param)
		end,
		function ( ... )
			target:log('MainScene:onItemClicked( view, param )#level='..view.level)
		end	}
		handler = handler[view.level]
		return handler and handler()
	end

	function MainScene:switchPanel( name )
		local handler = {}
		function handler.room( ... )
			self.btnHead:hide()
			self.btnBack:show()
			local c = self.areasContainer:hide():getChildrenCount()
			local count = self.roomsContainer:show():getChildrenCount()
			self:log(':switchPanel( '..name..' )#count={room='..count..', area='..c..'}')
		end
		function handler.area( ... )
			self.btnHead:show()
			self.btnBack:hide()
			local c = self.roomsContainer:hide():getChildrenCount()
			local count = self.areasContainer:show():getChildrenCount()
			self:log(':switchPanel( '..name..' )#count={area='..count..', room='..c..'}')
		end
		handler = handler[name]
		return handler and handler()
	end

	function MainScene.cleanContainer(container)
        local c = container:getChildrenCount()
        if c > 1 then
		    for i = 1, c do
		        container:getChildByTag(i):hide():removeSelf()
		    end
		end
		self:log('.cleanContainer(container)')
	end
end

function target:goBack(...)
    local params = self.params
    local t = type(params)
    local level = ((t=='table') and params[1]-1 ) or params or 1
    if level == 0 then level = 1 end
    self:showContent(level)
end

function target:reset( ... )
	self.areas_ = {}
	self.rooms_ = {}
	self.ready = false
	self.onlineusers_param = nil
	self:stopOnlineUsersTimer()
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
	if array and #array >0 then
		local info = array[1].data
		local id = info and info.nAreaID

		local area = self:getAreaById(id)
		local rooms = area.rooms
		for i,info in ipairs(array) do
			info.area = area
			table.insert(rooms, info)
		end
		rooms = self.rooms_
		table.insertto(rooms, array, #rooms+1)
	else -- failed
	end
end

function target:onConnection( event )
	if not self.hall:isConnected() then
		self:reset()
	end
end

function target:onHallReady()
	self:showContent()
	self.ready = true
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
			self:dispatchEvent({
				name = self.handler.ONLINE_USERS,
				body = {event = 'update', result = {'room', info.nItemID, c}}
				})
--			self:log(':onUpdateRoomUsersCount( event )room.online='..c..'.'..self:string(room.data.szRoomName))
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
		if info.data.nAreaID == nAreaID then
			table.insert(res, info)
		end
	end
	return res
end

local background_resovle
function target:roomParam( info, option )
	option = option or 'formal'
	local online = info.online or 0
	local hall = self.hall
	local level = self:getConfig().display_level or DEFAULT_LEVEL
	local handler = {formal = true, test = true}
	function handler.formal( ... )
		info = info.data
		
		local type = (bit.bor(info.dwOptions, mc.Flags.ROOM_OPT_NEEDDEPOSIT) and 'deposit') or 'score'
		local condition = {score = info.nMinScore, deposit = info.nMinDeposit}
		local param = {
            option = option,
            id = info.nRoomID,
			name = 'room',
			level = level,
			type = type,
			condition = condition[type] or '',
			online = online,
			activity = info.nGifID,
			background = background_resovle(info.nIconID),
			title = self:string(info.szRoomName),
			info = info
		}
		return param
	end
	function handler.test( ... )
		info.name = 'room'
		info.level = level
		return info
	end
	handler = handler[option]
	return handler and handler()
end
function target:areaParam( info )
	local rooms = info.rooms
	info = info.data
	local hall = self.hall
--	local rooms = self:getRooms(info.nAreaID)
	local function onlineCount( array )
		local res = 0
		for i,info in ipairs(array) do
			res = res + info.data.nUsersOnline
		end
		return res
	end
	local param = {
        option = 'formal',
        id = info.nAreaID,
		level = 1,
		name = 'area',
		online = onlineCount(rooms),
		background = background_resovle(info.nIconID),
		title = self:string(info.szAreaName),
		rooms = rooms,
		info = info
	}
	return param
end
function background_resovle( iconId )
	local backgrounds = {'gelou', 'leitai', 'two_pandas'}
	return backgrounds[iconId]
end
function target:showContent( level, container, param )
	local MainScene = self.target
	local containers = {
		MainScene.areasContainer,
		MainScene.roomsContainer
	}
	level = level or 1
	assert(level>0)
	container = container or containers[level]
	MainScene.cleanContainer(container)
	local handler = {
	function ( ... )
		local itemView = 'ItemView'
		local array = self.areas_ or {}
		for i,info in ipairs(array) do
			local param = self:areaParam(info)
			param.index = i
			local view = MainScene:addItem(param, itemView)
			info.view = view
			function info:update( ... )
				local c = onlineCount(self.rooms)
				local id = self.data.nAreaID
				self.online = c
				target:dispatchEvent({
					name = target.handler.ONLINE_USERS,
					body = {event = 'update', result = {'area', id, c}}
					})
			end
		end
		MainScene:layoutContent(level)
		if (self.timer == nil) then
			self:startOnlineUsersTimer()
		end
		MainScene:switchPanel('area')
		self.params = level
	end,
	function ( ... )
        if param == nil then return end

		local itemView = 'ItemView2'
		local app = MainScene:getApp()
		local option = param.option or app:getConfig('hall').offline.test
		local id = param.id or 0
		self.current = id
		option = option[3] or 'formal'
		local _, array = wrap2array(param.rooms)
		for i,info in ipairs(array) do
			local param = info.data and self:roomParam(info, option)
			if param then MainScene:addItem(param, itemView) end
		end
		MainScene:layoutContent(level)
--		MainScene:test(app:getConfig('hall').offline, 2, 'room')
		self:log(':showContent( param, option )#current='..id)
		MainScene:switchPanel('room')
		self.params = {level, param}
	end
	}
	handler = handler[level]
	return handler and handler()
end

function target:startOnlineUsersTimer( ... )
	local MainScene = self.target
	self:onUpdateRoomUsersCount('start')
	self.timer = MainScene
		:getScheduler()
		:scheduleScriptFunc(
			handler(target, target.onUpdateRoomUsersCount),
			self.config.onlineusers_interval or DEFAULT_INTERVAL, false)
end

function target:stopOnlineUsersTimer( ... )
	local timer = self.timer
	self.timer = timer and self.target:getScheduler():unscheduleScriptEntry(timer)
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

return target
