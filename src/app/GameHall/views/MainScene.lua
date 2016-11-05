local MainScene = class("MainScene", import('.extends.ViewBase'))
MainScene.RESOURCE_FILENAME = "res/HallCocosStudio/MainPanel/MainPanel.csb"
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
    self.btnHead = btnHead
    self.btnBack = self:onClicked('Btn_To_Area', self.goBack)
    self.btnBack:removeSelf()
    	:addTo(btnHead:getParent())
    	:align(cc.p(0.5, 0.5), btnHead:getPositionX(), btnHead:getPositionX())
    	:hide()
    self.userProfile = UserProfile:create(self:getApp(), 'UserProfile', self)

    self.hallScene = self:presenter('HallScene'):build(self)
    self:log(':onCreate().done')
end

function MainScene:onCleanup()
    self:log(':onCleanup()')
    self.hallScene:clean()
end

function MainScene:getContentView( name, param )
    local path = self:getApp():getConfig('hall')[1] or 'src.app.GameHall.views.content'
    local view = require(path..'.'..name):create(self:getApp(), name, param)
    return view
end

function MainScene:switchPanel( level )
    local panels = self.panelist
    local handler = {
    function ()
        self.btnHead:show()
        self.btnBack:hide()
    end;
    function ()
        self.btnHead:hide()
        self.btnBack:show()
    end;
    }
    function handler.switch( level )
        for i,panel in ipairs(panels) do
            if i == level then
                panel:show()
            else
                panel:hide()
            end
        end
        panels[level]:show()
    end
    handler.switch(level)
    handler = handler[level]
    return handler and handler()
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
