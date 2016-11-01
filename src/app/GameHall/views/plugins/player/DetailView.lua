local target = class("DetailView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/HallCocosStudio/PersonalInfo/PersonalInfo.csb"


function target:onCreate(param)
	self:initLayout()
    self:closeButton('topline.Button_1')
end

return target