local target = class("ItemBase", cc.load("mvc").ViewBase)

function target:tagEvent()
	return self:getName()..'_'..(self:getData().id or '')
end

function target:onEnter()
	local model = self:getApp():model('RoomSpace')
	model:on(model.handler.ONLINE_USERS,
		handler(self, self.updatelineUsers), self:tagEvent())
end
function target:onExit()
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

function target:onlineUsers( count ) -- override
end

return target