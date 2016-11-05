local target = class("HelpView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/HallCocosStudio/Help/Help.csb"


function target:onCreate(param)
	self:initLayout()

    self:onClose('Panel_2.Button_1')
end


return target