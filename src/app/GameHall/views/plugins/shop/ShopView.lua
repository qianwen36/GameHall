local target = class("ShopView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/HallCocosStudio/Shop/Shop.csb"


function target:onCreate(param)
	self:initLayout()
    self:onClose('Panel_1.Button_1')
end

return target