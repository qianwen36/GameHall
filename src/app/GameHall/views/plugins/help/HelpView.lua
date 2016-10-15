local target = class("HelpView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/help/help.csb"


function target:onCreate(param)
	self:initLayout()

    self:closeButton('Panel_2.Button_1')
end


return target