local target = class("ItemView2", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/Room/Room.csb"


function target:onCreate(param)
	local name = param.name or 'test'
	self:setName(name)

	local button = self:nodeFromPath('Room_Button')
    self:indexResource(button, {
        txTitle = 'Text_Room_Name',
        txOnline = 'Text_Online'
    })
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
	self:setTitle(param.title)
	self:setCondition(param.type, param.condition)
	self:onlineUsers(param.online or '')
	self:setCorner(param.activity)
	self.button = button
end

function target:tagEvent()
	return self:getName()..self:getData().id
end
function target:onEnter( ... )
	local model = self:getApp():model('RoomSpace')
	model:on(model.handler.ONLINE_USERS,
		handler(self, self.updatelineUsers), self:tagEvent())
end
function target:onExit( ... )
	local model = self:getApp():model('RoomSpace')
	model:off(self:tagEvent())
end

function target:updatelineUsers( event )
	local result = event.body.result
	local name, id, count = unpack(result)
	local param = self:getData()
	if name == param.name
	and id == param.id then
		self:onlineUsers(count)
	end
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