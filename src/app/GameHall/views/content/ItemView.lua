local target = class("ItemView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/Room/Area.csb"

local DEFAULT_TITLE = 'baiyinggu'
local DEFAULT_BACKGROUND = 'gelou'

function target:onCreate(param)
	local name = param.name or 'test'
	self:setName(name)

	local button = self:nodeFromPath('Area_Button')
	self.button = button
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

	self:setCondition(param.condition or '')
	self.wOnline = self.txOnline:getString()
	self:onlineUsers(param.online or '')
	self:setBackground(param.background or DEFAULT_BACKGROUND)
	self:setTitle(param.title or DEFAULT_TITLE)
end

function target:tagEvent()
	return self:getName()..'_'..self:getData().id
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

function target:setCondition( param )
	self.txCondition:setString(param)
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
	local map = self.titles_
	local set, node = nodeSwitch(map, name)
	if set then
		local ref = map[DEFAULT_TITLE]
		self.button:add(node)
		node:align(cc.p(0.5,0.5),
				ref:getPositionX(),
				ref:getPositionY())
		node:setString(name)
	end
	return self
end

return target