local target = class("LogoScene", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/HallCocosStudio/HallCommon/loading.csb"

function target:onCreate(scene)
	local node = self:getResourceNode()
	local size = display.size
    self:nodeFromPath('bk'):setContentSize(size)
    node:setName(self:getName())
        :removeSelf()
    	:addTo(scene)
    	:align(cc.p(0.5,0.5), size.width/2, size.height/2)
    ccui.Helper:doLayout(node)
    local layer = cc.CSLoader:createNode("res/HallCocosStudio/HallCommon/ForbiddenEx.csb")
    layer:addTo(node)
    	:setLocalZOrder(-1)
    	:setContentSize(size)
    ccui.Helper:doLayout(layer)
end

function target:loading()
	local action = cc.CSLoader:createTimeline(self.RESOURCE_FILENAME)
	self:getResourceNode():runAction(action)
	action:gotoFrameAndPlay(0, true)
end

return target