local target = class("SafeBoxView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/safebox/safebox.csb"
target.vPassword = import('.SafeBoxPassword')

local txConfig = {
	TIP_INPUT = '请输入数额~'
}
function target:onCreate(param)
	self:initLayout()
	local nodeSet, image = self:indexResource( 'Image_1', {
		txDepoistSafeBox = 'Text_2_0',
		txDepoistGame = 'Text_2_0_0',
		txField = 'TextField_1'
		})
	table.merge(self, nodeSet)
	self.amount_ = ''
	local txField = nodeSet.txField
	local function txField_handler( event )
		local handler = {INSERT_TEXT = true, DELETE_BACKWARD = true}
		function handler.INSERT_TEXT( ... )
			local str = txField:getString()
			if tonumber(str) == nil then
				txField:setString(self.amount_)
			else
				self.amount_ = str
			end
		end
		function handler.DELETE_BACKWARD( ... )
			self.amount_ = txField:getString()
		end

		handler = handler[event.name]
		return handler and handler()
	end
	txField:onEvent(txField_handler)
	self:onClicked('Image_1.Button_5_0', self.onSave2Box)
	self:onClicked('Image_1.Button_5_0_0', self.onTake2Game)
    self:closeButton('Image_1.Button_7')
    self.safebox = self:presenter('SafeBox'):build(self)
end

function target:onEnter()
	self.safebox:prepare()
end

function target:onExit()
	self.safebox:clear()
end

function target:onSave2Box()
	local amount = self:amount()
	if amount > 0 then
		self.safebox:save(amount)
	end
end
function target:onTake2Game()
	local amount = self:amount()
	if amount > 0 then
		self.safebox:take(amount)
	end
end

function target:amount()
	local amount = self.amount_
	if amount == '' then
		self:showToast(txConfig.TIP_INPUT)
	end
	return tonumber(amount) or 0
end

function target:refresh( target, amount )
	local handler = {safebox = true, gamedeposit = true}
	function handler.safebox( ... )
		self.txDepoistSafeBox:setString(tostring(amount))
	end
	function handler.gamedeposit( ... )
		self.txDepoistGame:setString(tostring(amount))
	end
	handler = handler[target]
	return handler and handler()
end

function target:promptPassword(handler)
	local view = self.vPassword:create(self:getApp(), 'password', {handler = handler, parent = self})
	view:show()
end

return target