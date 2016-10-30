local Base = import('.ItemBase')
local target = class("ItemView2", Base)
target.RESOURCE_FILENAME = "res/hallcocosstudio/Room/Room.csb"


function target:onCreate(info)
	local button = self:nodeFromPath('Room_Button')
    local nodeSet = self:indexResource(button, {
        txTitle = 'Text_Room_Name',
        txOnline = 'Text_Online'
    })
    table.merge(self, nodeSet)
    local btnDeposit = self:nodeFromPath('Text_Condition_Liang', button)
    local btnScore = self:nodeFromPath('Text_Condition_Feng', button)
    self.btnConditions = {
    	deposit	= btnDeposit,
    	score	= btnScore,
    }
	self.btnCorners = {
		self:nodeFromPath('Image_1', button),
		self:nodeFromPath('Image_1_1', button),
	}
    self.words = {
    	online = self.txOnline:getString(),
    	deposit	= btnDeposit:getString(),
    	score	= btnScore:getString(),
	}
	self:setTitle(info.name)
	self:setCondition(info.type2, info.condition)
	self:onlineUsers(info.online or '')
	self:setCorner(info.gift)
	self.button = button

	Base.onCreate(self, info)
end

function target:getButton()
	return self.button
end

function target:setTitle( text )
	self.txTitle:setString(text)
end

function target:setCorner( id )
	local array = self.btnCorners
	for i,button in ipairs(array) do
		if i == id then
			button:show()
		else
			button:hide()
		end
	end
end

function target:onlineUsers( text )
	self.txOnline:setString(text..self.words.online)
end

function target:setCondition( type, condition )
	local map = self.btnConditions
	local button = map[type]
	if button then
		local text = condition..self.words[type]
		button:setString(text)
	end
	for k,button in pairs(map) do
		if k == type then
			button:show()
		else
			button:hide()
		end
	end
end

return target