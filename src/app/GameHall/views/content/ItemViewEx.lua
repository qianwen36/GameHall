local Base = import('.ItemBase')
local target = class("ItemViewEx", Base)
target.RESOURCE_FILENAME = "res/HallCocosStudio/Room/RoomModel2.csb"

local DEFAULT_BACKGROUND = 'gelou'
function target:onCreate(info)
	local button = self:nodeFromPath('Room_Button')
	self.txOnline = self:nodeFromPath('Text_Online', button)
	self.txName = self:nodeFromPath('Text_Room_Name', button)
	self.txConditions = self:indexResource(button, {
		deposit = 'Text_Condition_Liang',
		score = 'Text_Condition_Feng',
		})
	self.wCondition = {deposit = 0, score = 0}
	for k,node in pairs(self.txConditions) do
		self.wCondition[k] = node:getString()
		node:hide()
	end

	self.button = button
	self.backgrounds_ = {
		two_pandas = self:nodeFromPath('two_pandas_backimage', button),
		leitai = self:nodeFromPath('leitai_backimage', button),
		gelou = self:nodeFromPath('gelou_backimage', button)
	}
	self.coner = self:indexResource(button,{
			'Image_1','Image_1_1'
		})
	for i,node in ipairs(self.coner) do
		node:hide()
	end

    local icon = info.icon +1
	local background = self:presenter('MainPanel'):getConfig('display').background
	if info.area ~= nil then
		self:setCondition(tostring(info.condition), info.type2)
		local coner = self.coner[info.gift]
		coner = coner and coner:show()
	end
	self.wOnline = self.txOnline:getString()
	self:onlineUsers(info.online or '')
	self:setBackground(background or DEFAULT_BACKGROUND)
	self:setTitle(info.name or '')

	Base.onCreate(self, info)
end

function target:getButton()
	return self.button
end

function target:setCondition( tx, type_ )
	type_ = type_ or 'score'
	tx = tx..self.wCondition[type_]
	self.txConditions[type_]:setString(tx):show()
	return self
end

function target:onlineUsers( param )
	self.txOnline:setString(param..self.wOnline)
end

local function nodeSwitch( map, tag )
	tag = string.lower(tag)
	for k,node in pairs(map) do
		node:hide()
	end
	local node = map[tag]
	node = node and node:show()
	local tx = node==nil
	if tx then
		local title = 'title'
		node = map[title]
		if node == nil then
			node = ccui.Text:create()
			map[title] = node
		end
	end
	return tx, node
end
function target:setBackground( tag )
	nodeSwitch(self.backgrounds_, tag)
	return self
end

function target:setTitle( name )
	self.txName:setString(name)
	return self
end

return target
