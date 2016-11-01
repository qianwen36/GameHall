local target = cc.load('form').build('ModuleBase')

local LoadingLayer = import('.GameHall.views.LoadingLayer')
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
--[[
function target:nextSchedule( func, interval ) -- overload]]
function target:nextSchedule( func, arg, interval )
	local timer
	interval = interval or tonumber(arg) or 0
	timer = Scheduler:scheduleScriptFunc(function ( ... )
		self:log(':nextSchedule( func )#timer=', tostring(timer), ', #func=', tostring(func))
		timer = timer and Scheduler:unscheduleScriptEntry(timer)
		func(self, arg)
	end, interval, false)
	return timer
end

local LAYER_WATING = 'OPERATE_WAITING'
function target:waiting()
	local scene = Director:getRunningScene()
	if self.wait_ ~=nil then
		self:log(':waiting()#', LAYER_WATING, ' layer exist')
		return
	end
	LoadingLayer:create(self:getApp(), LAYER_WATING, scene):loading()

	self.wait_ = self:nextSchedule(self.finish, 5)
end

function target:terminate()
	local timer = self.wait_
	if (timer ~= nil) then
		self.wait_ = Scheduler:unscheduleScriptEntry(timer)
		local scene = Director:getRunningScene()
		local node = scene:getChildByName(LAYER_WATING)
		if node then node:removeSelf() end
	end
end

function target:tagEvent( eventName )
	return self:tag()..eventName
end

return target