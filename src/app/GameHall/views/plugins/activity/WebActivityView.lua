local target = class("WebActivityView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/webactivity/webactivity.csb"


function target:onCreate(param)
	self:initLayout()
    self:closeButton('Panel_2.Button_1')
end

return target