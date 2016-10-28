local MainScene = class("MainScene", import('.extends.ViewBase'))
--local MainScene = class("MainScene", require('src.app.GameHall.views.extends.ViewBase'))
MainScene.RESOURCE_FILENAME = "res/hallcocosstudio/mainpanel/mainpanel.csb"
local UserProfile = import('.content.UserProfile')

function MainScene:onCreate()
	self:initLayout()

    local btnHead = self:onClicked('Panel_Player.Button_Head', self.onPlayerheadButton)
    self:onClicked('Panel_RightUp.Button_Setting', self.onSettingButton)
    self:onClicked('Panel_RightUp.Button_Help', self.onHelpButton)
    self:onClicked('Panel_RightUp.Button_Activity', self.onDailyButton)
    self:onClicked('Panel_Down.Button_quick_start', self.onQuickStart)
    self:onClicked('Panel_Down.Button_safebox', self.onSafeboxButton)
    self:onClicked('Panel_Down.Button_Shop', self.onShopButton)
    self:onClicked('Panel_Down.Button_Activity', self.onActivityButton)
    self.panelist = self:indexResource(self:getResourceNode(),{
    		'Area_List',
    		'Room_List',
    	})
    self.btnBack = self:onClicked('Btn_To_Area', self.goBack)
    self.btnBack:removeSelf()
    	:addTo(btnHead:getParent())
    	:align(cc.p(0.5, 0.5), btnHead:getPositionX(), btnHead:getPositionX())
    	:hide()
    self.userProfile = UserProfile:create(self:getApp(), 'UserProfile', self)

    self.hallScene = self:presenter('HallScene'):build(self)
    self:log(':onCreate().done')
end

function MainScene:primaryPanel()
	return self.panelist[1]
end

function MainScene:secondaryPanel()
	return self.panelist[2]
end

function MainScene:updateProfile(info)
	self.userProfile:updateProfile(info)
end

function MainScene:updateGameInfo(info)
	self.userProfile:updateGameInfo(info)
end

function MainScene:goBack()
	self.hallScene:goBack()
end

function MainScene:onQuickStart( ... )
	self:showToast('MainScene:onQuickStart( ... ).TEST')
end

function MainScene:onPlayerheadButton()
	self:showPlugin('player_detail')
end

function MainScene:onSafeboxButton( )
	self:showPlugin('safebox')
end

function MainScene:onShopButton(  )
	self:showPlugin('shop')
end

function MainScene:onActivityButton(  )
	self:showPlugin('web_activity')
end

function MainScene:onHelpButton(  )
	self:showPlugin('help')
end
function MainScene:onDailyButton(  )
	self:showPlugin('daily')
end
function MainScene:onSettingButton(  )
	self:showPlugin('setting')
end
return MainScene
