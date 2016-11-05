local target = class("WebActivityView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/HallCocosStudio/WebActivity/WebActivity.csb"


function target:onCreate(param)
	self:initLayout()
    self:onClose('Panel_2.Button_1')
end

return target