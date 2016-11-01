local target = class("UserProfile", cc.load("mvc").ViewBase)

function target:onCreate(root)
	local node = self:setResourceNode(root:nodeFromPath('Panel_Player'))
	local headButton
	self:nodeFromPath('button_head_small'):hide()
	self.unlogon = self:nodeFromPath('Panel_defaulticon_L')
	self.avatar, self.frame = self:indexResource('Button_Head',{
			male = 'Image_Boy',
			female = 'Image_Girl',
		})
	local map = self:indexResource(node, {
		txName = 'Text_Name',
		txDeposit = 'Panel_deposit.Text_Deposit',
		txScore = 'Panel_score.Text_playerscore',
		})
	table.merge(self, map)
	self.memIcons = self:indexResource(node, {'Image_Mem', 'Image_Mem_F'})
	self.nameDefault = self.txName:getString()
	self:addTo(root)

	self:avatarSet()
	self:updateGameInfo({deposit = 0, score = 0})
	self:updateProfile({vip = 0})
end

function target:avatarSet( sex )
	local avatar = self.avatar
	self.frame:hide()
	self.unlogon:show()
	for k,node in pairs(avatar) do
		node:hide()
	end
	if sex~=nil then
		self.unlogon:hide()
		self.frame:show()
		local node = avatar[sex]
		node:show()
	end
end

function target:updateProfile(info)
	self:avatarSet(info.sex)
	self.txName:setString(info.nick or self.nameDefault)
	for i,icon in ipairs(self.memIcons) do
		icon:hide()
	end
	local icon = (info.vip >0 and 1) or 2
	icon = self.memIcons[icon]
	icon:show()
end

function target:updateGameInfo(info)
	self.txDeposit:setString(tostring(info.deposit))
	self.txScore:setString(tostring(info.score))
end

return target