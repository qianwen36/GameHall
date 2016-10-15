local ViewBase = cc.load("mvc").ViewBase
local Director = cc.Director:getInstance()

ViewBase.BUTTON_CLICKED = 'clicked'

function ViewBase:ctor(app, name, param)
    self:enableNodeEvents()
    self.app_ = app
    self.name_ = name

    -- check CSB resource file
    local res = rawget(self.class, "RESOURCE_FILENAME")
    if res then
        self:createResoueceNode(res)
    end
    if self.onCreate then self:onCreate(param) end
	self.param_ = param
end

function ViewBase:getData()
	return self.param_ or {}
end

function ViewBase:nodeFromPath(path, root)
    root = root or self:getResourceNode()
    assert(root, 'need root node')
    local nn = string.split(path, '.')

    local node = root
    for i = 1, #nn do
        node = node:getChildByName(nn[i])
    end
    return node
end

function ViewBase:indexResource(parent, map)
    assert(parent, 'need parent node')
    if type(parent) == 'string' then
    	parent =  self:nodeFromPath(parent)
    end
    for key, name in pairs(map) do
        self[key] = self:nodeFromPath(name, parent)
    end
    return parent
end

function ViewBase:initLayout( )
	local size = Director:getVisibleSize()
	local node = self:getResourceNode()
	node:align(cc.p(0,0), 0,0)
		:setContentSize(size)
    ccui.Helper:doLayout(node)
end

function ViewBase:onClicked(node, handler)
	if type(node) == 'string' then
		node = self:nodeFromPath(node)
	end
	if node ~= nil then
		if node.onTouch ~= nil then
			node:onTouch(function ( event )
				print('ViewBase:onClicked(node):onTouch('..event.name..')')
				if (event.name == 'ended') then
					handler(self, event)
				end
			end)
		else
--			local listener = cc.EventListenerTouchOneByOne:create()
--            local t = {
--            [cc.Handler.EVENT_TOUCH_BEGAN] = {
--                function (touch,event)
--                return true
--                end,
--                cc.Handler.EVENT_TOUCH_BEGAN },
--            [cc.Handler.EVENT_TOUCHES_ENDED] = {
--                function (touch,event)
--                handler(self)
--                return true
--                end,
--                cc.Handler.EVENT_TOUCHES_ENDED }
--            }
--			listener:registerScriptHandler(unpack(t[cc.Handler.EVENT_TOUCH_BEGAN]))
--			listener:registerScriptHandler(unpack(t[cc.Handler.EVENT_TOUCHES_ENDED]))
--			node:getEventDispatcher()
--				:addEventListenerWithSceneGraphPriority(listener, node)
		end
	end
	return node
end

function ViewBase:showTost( text, delay )
	delay = delay or 1
	local name = '__toastTip'
	local scene = display.getRunningScene()
	local node = scene:getChildByName(name)
	if node== nil then
		local path = "res/HallCocosStudio/HallCommon/toasttip.csb"
		node = cc.CSLoader:createNode(path)
		node:setName(name):addTo(scene)
	end
	local Scheduler, timer, txNode
	txNode = self:nodeFromPath('Text_1', node):setString(text)
	Scheduler = self:getScheduler()
	timer = Scheduler:scheduleScriptFunc(function ( ... )
		timer = timer and Scheduler:unscheduleScriptEntry(timer)
		node:hide()
	end, delay, false)
	node:show()
end

function ViewBase:blockLayer( node )
	local name = '__forbiddenLayer'
	local layer = self:getChildByName(name)
	if layer then
		print('ViewBase:blockLayer(node)#'..name..' exist')
		layer:show()
		return layer
	end
	local path = "res/HallCocosStudio/HallCommon/Forbidden.csb"
	
	layer = cc.CSLoader:createNode(path)
    local size = self:getResourceNode():getContentSize()
	layer:setName(name)
		:addTo(self)
		:setContentSize(size)
	ccui.Helper:doLayout(layer)
	self.block = name
	return layer
end
function ViewBase:showPlugin( name )
	local cls, param = self:getApp():plugin(name)
	local app = self:getApp()
	local view = cls:create(app, name, param)
	param = param or {}
	local display = app:wrapParam(param.display, 'normal')
	local handler = {}
	function handler.normal()
		self:addChild(view)
		return self
	end
	function handler.shade()
		local layer = self:blockLayer(view)
		layer:addChild(view)
		self:closeButton(layer, param)
		return self
	end
	function handler.block()
		local layer = self:blockLayer(view)
		layer:addChild(view)
		return self
	end
	function handler.scene()
		local param = clone(display)
		table.remove(param, 1)
		view:showWithScene(unpack(param))
		view.backScene_ = self:getName()
		return self
	end
	handler = handler[display[1]]
	return handler and handler()
end

function ViewBase:closeButton(node, param)
    if param~=nil then node.param_ = param end

    self:onClicked(node, function(node)
	    local param = node.param_ or {}
    	local app = node:getApp()
	    local display = app:wrapParam(param.display, 'normal')
	    display = display[1]
	    if display == 'scene' then
	    	local name = node.backScene_ or app:getConfig('defaultSceneName')
	    	app:enterScene(name)
	    else
		    if display ~= 'normal' then
	        	local layer = node:getParent()
	        	layer:hide()
		    end
		    node:removeSelf()
		end
    end)
end

return ViewBase