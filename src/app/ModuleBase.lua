local target = cc.load('form').build('ModuleBase')

local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

function target:getConfig( name )
	return self.app_:getConfig(name)
end

function target:getApp()
	return self.app_
end

function target:init( app )
	self.app_ = app
	self:reset()
	return self
end

function target:reset()
	self:definition(':reset()')
end

function target:timerScheduler( interval, func, pause)
	pause = pause or false
	return Scheduler:scheduleScriptFunc(handler(self,func), interval, pause)
end

function target:timerStop( timer )
	timer = timer or Scheduler:unscheduleScriptEntry(timer)
end

function target:nextSchedule( func )
	local timer
	timer = Scheduler:scheduleScriptFunc(function ( ... )
		timer = timer or Scheduler:unscheduleScriptEntry(timer)
		func(self)
	end, 0, false)
end

function target:tagEvent( eventName )
	return self:tag()..eventName
end

return target