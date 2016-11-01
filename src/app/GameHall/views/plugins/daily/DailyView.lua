local target = class("DailyView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/HallCocosStudio/DailyActivity/DaliyActivity.csb"


function target:onCreate(param)
	self:initLayout()
    self:closeButton('Image_1.Button_2')
end

return target