local MainScene = class("MainScene", require('src.app.GameHall.views.extends.ViewBase'))
MainScene.RESOURCE_FILENAME = "res/hallcocosstudio/mainpanel/mainpanel.csb"

local Director = cc.Director:getInstance()
-------------------------------------------------------------

function MainScene:onCreate()
	self:initLayout()

    local btnHead = self:onClicked('Panel_Player.Button_Head', self.onPlayerheadButton)
    self:onClicked('Panel_RightUp.Button_Setting', self.onSettingButton)
    self:onClicked('Panel_RightUp.Button_Help', self.onHelpButton)
    self:onClicked('Panel_RightUp.Button_Activity', self.onDailyButton)
    self:onClicked('Panel_Down.Button_quick_start', self.onQuickStart)
    self:onClicked('Panel_Down.Button_safebox', self.onSafeboxButton)
    self:onClicked('Panel_Down.Button_Shop', self.onShopButton)
    self:onClicked('Panel_Down.Button_Activity', self.onActivityButton)
    self:indexResource(self:getResourceNode(),{
    		areasContainer = 'Area_List',
    		roomsContainer = 'Room_List',
    	})
    self.btnBack = self:onClicked('Btn_To_Area', self.goBack)
    self.btnBack:addTo(btnHead:getParent())
    	:align(cc.p(0.5, 0.5), btnHead:getPositionX(), btnHead:getPositionX())
    	:hide()

    self.btnHead  = btnHead
end

function MainScene:onEnter()
    local param = self:getApp():getConfig('hall')
    self.param_ = param
    self:test('area', param.offline.areas)
end

function MainScene:goBack( ... )
	self:switchContent('area')
end

function MainScene:onQuickStart( ... )
	self:showTost('MainScene:onQuickStart( ... ).TEST')
end

local function wrap2array( param )
	param = clone(param)
	local name = table.remove(param, 1)
	if #param ==1 then
		param = {param}
	end
	return name, param
end
function MainScene:test( test, param )
	if param==nil or not test then return end
	test = test or 'area'
	local handler = {}
	function handler.area(  )
		local name, array = wrap2array(param)
		for i, item in ipairs(array) do
			self:addItem(name, item)
		end
		self:showContent(test)
	end
	function handler.room(  )
		local array = param
		for i, item in ipairs(array) do
			self:addItem(item[1], item)
		end
		self:showContent(test)
	end
	handler = handler[test]
	return handler and handler()
end

function MainScene:showContent( name )
	local handler = {}
	local function alignChildren( container )
		local c = container:getChildrenCount()
		if c <= 4 then
			local size = container:getContentSize()
			local x = 0
			local y = size.height/2
			local d = size.width/(c+1)
			for i=1, c do
				x = x + d
				container:getChildByTag(i):move(x, y)
			end
		end
		return container
	end
	function handler.area()
		alignChildren(self.areasContainer):show()
		return self
	end
	function handler.room(  )
		alignChildren(self.roomsContainer):show()
		return self
	end
	handler = handler[name]
	return handler and handler()
end

function MainScene:addItem( name, param )
	local container = {
		AreaView = self.areasContainer,
		RoomView = self.roomsContainer
	}
	container = container[name]
	local count = container:getChildrenCount()
	name = name or 'AreaView'
	local view = self:getContentView(name, param)
		:setTag(count+1)
		:addTo(container)
	local y = container:getContentSize().height/2
	local size = view:getContentSize()
	if count >0 then
		local node = container:getChildByTag(count)
		local pos = cc.p(node:getPositionX(), node:getPositionY() + size.width/2)
		view:move(pos.x, y)
	else
		view:move(size.width/2, y)
	end
	view:addEventListener(self.BUTTON_CLICKED, function ( data )
		self:onItemClicked(data.target)
	end)
end

function MainScene:onItemClicked( view )
	local param = view:getData()
	local enter = param.area==nil
	local name = (enter and 'room') or 'area'
	self:switchContent(name)
	if enter then
		self:test(name, param.rooms)
	end
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
    for i = 1, container:getChildrenCount() do
        container:removeChildByTag(i)
    end
end

function MainScene:getContentView( name, param )
	local path = self.param_[1] or 'src.app.GameHall.views.content'
	local view = require(path..'.'..name):create(self:getApp(), name, param)
	return view
end

function MainScene:onPlayerheadButton()
	self:showPlugin('player_detail')
end

function MainScene:onSafeboxButton( )
	self:showPlugin('safebox')
end

function MainScene:onShopButton(  )
	self:showPlugin('shop')
end

function MainScene:onActivityButton(  )
	self:showPlugin('web_activity')
end

function MainScene:onHelpButton(  )
	self:showPlugin('help')
end
function MainScene:onDailyButton(  )
	self:showPlugin('daily')
end
function MainScene:onSettingButton(  )
	self:showPlugin('setting')
end
return MainScene
