local target = class("SafeBoxView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/safebox/safebox.csb"


function target:onCreate(param)
	self:initLayout()
	local nodeSet, image = self:indexResource( 'Image_1', {
		txDepoistSafeBox = 'Text_2_0',
		txDepoistGame = 'Text_2_0_0',
		txField = 'TextField_1'
		})
	table.merge(self, nodeSet)
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
	self.safebox:save(amount)
end
function target:onTake2Game()
	local amount = self:amount()
	self.safebox:take(amount)
end

function target:amount()
	local amount = self.txField:getString()
	return tonumber(amount)
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

return target