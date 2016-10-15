local target = class("SettingView", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/hallcocosstudio/settings/settings.csb"

function target:onCreate(param)
	self:initLayout()
    self:closeButton('Image_1.Button_2')
    self:onClicked('Image_1.musicDisableBt', self.onBtnMusicMute)
    self:onClicked('Image_1.musicEnableBt', self.onBtnMusicEnable)
    self:onClicked('Image_1.soundsDisableBt', self.onBtnSoundMute)
    self:onClicked('Image_1.soundsEnableBt', self.onBtnSoundEnable)

end

function target:onBtnMusicMute( ... )
	-- body
end
function target:onBtnMusicEnable( ... )
	-- body
end
function target:onBtnSoundMute( ... )
	-- body
end
function target:onBtnSoundEnable( ... )
	-- body
end

return target