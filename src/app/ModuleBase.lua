local target = cc.load('form').build('ModuleBase')

function target:getConfig( name )
	return self.app_:getConfig(name)
end

function target:getApp()
	return self.app_
end

function target:init( app )
	self.app_ = app
	return self
end

return target