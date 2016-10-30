local target = class("ItemBase", cc.load("mvc").ViewBase)

function target:onCreate(info)
	local level = info.param[1]
	local panel = info.param[2]
	local name  = info.param[3] or 'test'
	self:setName(name)
	local button = self:getButton()
		:removeSelf()
		:addTo(panel)
	self:addTo(button)
	self.level = level
end

function target:onlineUsers( count ) -- override
	self:definition(':onlineUsers( count )')
end

return target