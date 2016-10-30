local Base = import('.BasePresenter')
local target = cc.load('form').build('MainPanel', Base)

local TAG_ITEMNAME = 'ItemName'
local DEFAULT_LEVEL = 2
local DEFAULT_INTERVAL = 60

function target:reset()
	self.display = {
		tagItem = TAG_ITEMNAME,
		level = 1,
		refresh = false
	}
	Base.reset(self)
end
function target:build( view )
	self.view = view
	
	if (self.host == nil) then
		local host = self:model('RoomModel')
		host:on(host.MODEL_READY, handler(self, self.onHostRoomReady))
		host:on(host.EVENT_EXCEPTION_BREAK, handler(self, self.onCommunicationBreak))
		host:on(host.handler.ONLINE_USERS_UPDATE, handler(self, self.updateOnlineusers))
		self.host = host
	end

	return Base.build(self, view)
end

function target:getConfig( name ) -- method override
	local config = self.config
	if (config == nil) then
		config = Base.getConfig(self)
		self.config = config
	end
	if name ~= nil then
		local res = {
		interval = config.refresh.onlineusers or DEFAULT_INTERVAL,
		level = config.display.level or DEFAULT_LEVEL
		}
		return res[name] or config[name]
	end
	return config
end

function target:onCommunicationBreak( event )
--	self.ready = false
end

function target:onHostRoomReady()
	Base.ready(self, self.view)
	local interval = self:getConfig('interval')
	local array = {}
	local rooms = self.host:rooms()
	for i,info in ipairs(rooms) do
		array[i] = info.id
	end
	self.host:updateOnlineusers(array, interval)
end

function target:goBack()
	local level = self.display.level -1
	if level == 0 then level = 1 end
	self:showContent(level)
end

function target:onEnter()
	-- restore the scroll percent
end
function target:onExit()
	local param = self.display
	local view = self.view
	local containers = {view:primaryPanel(), view:secondaryPanel()}
end

function target:prepare(view)
	if view then
		function view:addItem(info, itemView )
			local level = info.param[1]
			local panel = info.param[2]
			local count = panel:getChildrenCount()
			local item = self:getContentView(itemView, info)
			local button = item:getButton():setTag(count+1)
			local y = panel:getContentSize().height/2
			local size = button:getContentSize()
			if count >0 then
				local node = panel:getChildByTag(count)
				local pos = cc.p(node:getPositionX(), node:getPositionY() + size.width/2)
				button:move(pos.x, y)
			else
				button:move(size.width/2, y)
			end
			self:onClicked(button, self.onItemClicked)
			return item
		end
		function view:onItemClicked( event )
			local view = event.target:getChildByName(target.display.tagItem)
			local info = view:getData()
			local level = info.param[1]
			if info.rooms then
				target:showContent(level+1, info)
			else
				target:enterRoom(info)
			end
			self:log(':onItemClicked( event ).done #', info.name)
		end
		function view.clear(panel)
			local c = panel:getChildrenCount()
			if c > 1 then
				for i = 1, c do
					panel:getChildByTag(i):hide():removeSelf()
				end
			end
			self:log('.clear(panel)')
		end
		self.display.refresh = true
		self:showContent()
	else
		self.host:prepare()
	end
end

function target:enterRoom( info )
end

function target:updateOnlineusers()
	local view = self.view
	local param = self.display
	if (view) then
		local INFO = {self.host:areas(), self.host:rooms()}
		local array = INFO[param.level]
		for i,info in ipairs(array) do
			info.view:onlineUsers(info.online)
		end
	end
end

local layoutContent -- function( level, container )
--[[
function target:showContent( 1 )
function target:showContent( 2, info )]]
function target:showContent(level, info)
	local param = self.display
	level = level or param.level or 1
	info = info or param.info

	local view = self.view
	local containers = {view:primaryPanel(), view:secondaryPanel()}
	local panel = containers[level]
	local itemView = self:getConfig('display')
	if #itemView == 0 then
		itemView = {'ItemView', 'ItemView2'}
	end
	itemView = itemView[level]
	local view = self.view
	local function view_initPanel( array )
		array = array or {}
		for i,info in ipairs(array) do
			info.param = {level, panel, param.tagItem}
			local view = view:addItem(info, itemView)
			info.view = view
		end
		layoutContent(level, panel)
	end
	local handler = {
	function ( ... )
		if panel:getChildrenCount() == 0 then
			local model = self.host
			local array = model:areas() or {}
			if self:getConfig('level') ==1 then
				array = model:rooms()
			end
			view_initPanel(array)
		end
		view:switchPanel(level)
	end,
	function ( ... )
		if param.refresh or param.info ~= info then
			view.clear(panel)
			local array = info.rooms
			view_initPanel(array)
		end
		view:switchPanel(level)
	end
	}
	handler = handler[level]
	if (handler) then
		handler()
	end
	param.refresh = false
	param.level = level
	param.info = info
end

local function layoutMainLinear( container )
	local x, y, c
	c = container:getChildrenCount()
	if c == 0 then return container end

	local item = container:getChildByTag(1)
	local size = container:getContentSize()
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
local function layoutRoomGrid( container )
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
function layoutContent( level, container )
	local function vertialCenter( container )
		local size = container:getParent():getContentSize()
		container:align(cc.p(0, 0.5), 0, size.height/2)
		return container:show()
	end
	local handler = {
	function ()
		vertialCenter(layoutMainLinear(container))
	end,
	function()
		vertialCenter(layoutRoomGrid(container))
	end
	}
	handler = handler[level]
	return handler and handler()
end

return target