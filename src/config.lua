
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2

-- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- show FPS on screen
CC_SHOW_FPS = true

-- disable create unexpected global variable
CC_DISABLE_GLOBAL = true

-- for module display
CC_DESIGN_RESOLUTION = {
	width = 1280,
	height = 720,
	autoscale = "FIXED_WIDTH",
--    width = 960,
--    height = 640,
--    autoscale = "SHOW_ALL",
    callback = function(framesize)
        local ratio = framesize.width / framesize.height
        if ratio <= 1.34 then
            -- iPad 768*1024(1536*2048) is 4:3 screen
--            return {autoscale = "SHOW_ALL"}
			return {autoscale = "FIXED_WIDTH"}
        end
    end
}

require 'src.cocos.cocos2d.json'
Controller = {
	viewsRoot = {'src.app.GameHall.views.extends', 'src.app.GameHall.views'},
	modelsRoot = {'src.app.GameHall.models'},
	presentersRoot = {'src.app.GameHall.presenters', 'src.app.GameHall.presenters.plugins'},

	hall = {'src.app.GameHall.views.content',
		offline = require('src.app.GameHall.config.HallTest'),
		config = require('src.app.GameHall.config.HallTest'),
		ui = require('src.app.GameHall.config.HallTest'),
	},
	game = {'src.app.Game.mMyGame.MyGameScene', name = 'MyGameScene'},
	plugins = {
		root = 'src.app.GameHall.views.plugins',
		-- pluginname = relative_path or {relative_path, display = ['block', 'shade', 'normal', 'scene']}
		player_detail = {'player.DetailView', display=scene},
		setting = 'setting.SettingView',
		help = {'help.HelpView', display='scene'},
		daily = 'daily.DailyView',
		safebox = {'safebox.SafeboxView', display='block'},
		shop = {'shop.ShopView', display='scene'},
		web_activity = {'activity.WebActivityView', display='scene'}
	},
}

function Controller.plugins:get( name )
	local t = self[name]
	local path, param
	if (type(t)=='table') then
        t = clone(t)
		path = table.remove(t, 1)
		param = t
	else
		path = t
	end
	return require(self.root..'.'..path), param
end