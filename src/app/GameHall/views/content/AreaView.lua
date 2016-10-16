local target = class("AreaView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/Room/Area.csb"


function target:onCreate(param)
	local name = param.name or 'test'
	self:setName(name)

	cc.load('event'):create():bind(self)

	local button = self:onClicked('Area_Button', self.onBtnClicked)
	self:indexResource(button, {
		txCondition = 'Text_Condition',
		txOnline = 'Text_Online'
		})
	self.backgrounds_ = {
		two_pandas = self:nodeFromPath('two_pandas_backimage', button),
		leitai = self:nodeFromPath('leitai_backimage', button),
		gelou = self:nodeFromPath('gelou_backimage', button)
	}
	self.titles_ = {
		baiyinggu = self:nodeFromPath('baiyinggu_nameimage', button),
		dadetong = self:nodeFromPath('dadetong_nameimage', button),
		guandimiao = self:nodeFromPath('guandimiao_nameimage', button),
		yuxianglou = self:nodeFromPath('yuxianglou_nameimage', button),
	}
	self.wOnline = self.txOnline:getString()
	self:setCondition(param.conditio or '')
	self:setOnline(param.online or '')
	self:setBackground(param.background or 'gelou')
	self:setTitle(param.title or 'baiyinggu')
end

function target:onBtnClicked( )
	self:dispatchEvent({
		name = self.handler.BUTTON_CLICKED,
		type = 'area',
		target = self })
end

function target:setCondition( param )
	self.txCondition:setString(param)
	return self
end
function target:setOnline( param )
	self.txOnline:setString(param..self.wOnline)
end

local function nodeSwitch( map, tag )
	tag = string.lower(tag)
	for k,node in pairs(map) do
		node:hide()
	end
	local node = map[tag]
	node = node and node:show()
end
function target:setBackground( tag )
	nodeSwitch(self.backgrounds_, tag)
	return self
end

function target:setTitle( tag )
	nodeSwitch(self.titles_, tag)
	return self
end

return target