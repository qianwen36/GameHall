local target = cc.load('form').build('BasePresenter', require('src.app.ModuleBase'))

function target:model( name )
	return self:getApp():model(name)
end

function target:reset()
	self.ready_ = false
end

function target:build(view)
	if (self:ready()) then
		self:prepare(view)
	end
	return self
end
--[[
function target:ready()
function target:ready( set )
function target:ready( view )]]
function target:ready( arg )-- overload
	if arg == nil then return self.ready_ end

	local t = type(arg)
	if t == 'boolean' then
		self.ready_ = arg
	else
		self.ready_ = true
		self:prepare(arg)
	end
	return self
end
function target:prepare(view)
	self:definition(':prepare(view)')
end

function target:clear()
	self:definition(':clear()')
end

return target