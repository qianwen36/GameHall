local MainScene = class("MainScene", import('.extends.ViewBase'))
--local MainScene = class("MainScene", require('src.app.GameHall.views.extends.ViewBase'))
MainScene.RESOURCE_FILENAME = "res/hallcocosstudio/mainpanel/mainpanel.csb"


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
    self:indexResource(self:getResourceNode(),{
    		areasContainer = 'Area_List',
    		roomsContainer = 'Room_List',
    	})
    self.btnBack = self:onClicked('Btn_To_Area', self.goBack)
    self.btnBack:removeSelf()
    	:addTo(btnHead:getParent())
    	:align(cc.p(0.5, 0.5), btnHead:getPositionX(), btnHead:getPositionX())
    	:hide()

    self.btnHead  = btnHead

    self:getApp():model('RoomSpace'):build(self)
    local model = self:getApp():model('BaseHall')
    model:on(model.handler.HALL_READY, handler(self, self.onHallReady))
    self.hall = model
    print(self:getName()..':onCreate().done')
end

function MainScene:onHallReady( ... )
    -- show content, and start login
    print(self:getName()..':onHallReady()')
    self:getApp():model('RoomSpace'):showContent(self.areasContainer)
    self:getApp():model('PlayerModel'):login(self.hall)
end

function MainScene:goBack( ... )
    self:getApp():model('RoomSpace'):goBack(...)
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
