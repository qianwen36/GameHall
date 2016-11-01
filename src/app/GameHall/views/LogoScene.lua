local target = class("LogoScene", cc.load("mvc").ViewBase)
target.RESOURCE_FILENAME = "res/HallCocosStudio/StartUp/logo.csb"


function target:onCreate()
	self:initLayout()
end

function target:onEnter()
    local app = self.app_
	local Scheduler = self:getScheduler()
    local timer
    timer = Scheduler:scheduleScriptFunc(function ()
    	timer = timer and Scheduler:unscheduleScriptEntry(timer)
	    app:enterScene('MainScene', 'CROSSFADE', 1)
    end, 1.0, false)
end
return target
