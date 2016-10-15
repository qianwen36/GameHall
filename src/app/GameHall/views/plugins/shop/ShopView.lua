local target = class("ShopView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/shop/shop.csb"


function target:onCreate(param)
	self:initLayout()
    self:closeButton('Panel_1.Button_1')
end

return target