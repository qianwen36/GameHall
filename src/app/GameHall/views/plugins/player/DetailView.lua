local target = class("DetailView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/personalinfo/personalinfo.csb"


function target:onCreate(param)
	self:initLayout()
    self:closeButton('topline.Button_1')
end

return target