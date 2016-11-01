local target = class("SafeBoxPassword", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/safebox/safeboxpassword.csb"


function target:onCreate(param)
	self:initLayout()
	self:dumpChildren()
	self:onClicked('Image_1.Button_5_7', self.onButtonCancel)
	self:onClicked('Image_1.Button_5_0_9', self.onButtonOK)
	self.txPassword = self:nodeFromPath('Image_1.Image_5.TextField_1')
	self:addTo(param.parent)
	self.func = param.handler
end

function target:onButtonOK()
	local password = self.txPassword:getString()
	self:close(password)
end

function target:onButtonCancel()
	self:close()
end

function target:close( password )
	self.func(password)
	self:removeSelf()
end

return target