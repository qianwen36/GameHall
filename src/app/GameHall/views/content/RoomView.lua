local target = class("AreaView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/Room/Room.csb"

local Director = cc.Director:getInstance()

function target:onCreate(param)
	local name = param.name or 'test'
	self:setName(name)

	cc.load('event'):create():bind(self)
	local button = self:onClicked('Room_Button', self.onBtnClicked)
end

function target:onBtnClicked( )
	self:dispatchEvent({
		name = self.BUTTON_CLICKED,
		type = 'room',
		target = self })
end

return target