local target = class("SafeBoxView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/safebox/safebox.csb"


function target:onCreate(param)
	self:initLayout()

    self:closeButton('Image_1.Button_7')
end


return target