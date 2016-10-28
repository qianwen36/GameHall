local target = class("UserProfile", cc.load("mvc").ViewBase)

function target:onCreate(root)
	local node = self:setResourceNode(root:nodeFromPath('Panel_Player'))
	self.avatar = self:indexResource('Button_Head',{
			male = 'Image_Boy',
			female = 'Image_Girl',
			unknown = 'Image_4'
		})
	local map = self:indexResource(node, {
		txName = 'Text_Name',
		txDeposit = 'Text_Deposit',
		imgVip = 'Image_Mem',
		})
	table.merge(self, map)
	self.nameDefault = self.txName:getString()
	self:addTo(root)
end

function target:avatarSet( sex )
	local avatar = self.avatar
	for k,node in pairs(avatar) do
		node:hide()
	end
	local node = avatar[sex] or avatar.unknown
	node:show()
end

function target:updateProfile(info)
	self:avatarSet(info.sex)
	self.txName:setString(info.nick or self.nameDefault)

	if info.vip >0 then
		self.imgVip:show()
	else
		self.imgVip:hide()
	end
end

function target:updateGameInfo(info)
	self.txDeposit:setString(tostring(info.deposit))
end

return target