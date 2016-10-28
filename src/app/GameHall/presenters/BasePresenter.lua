local target = cc.load('form').build('BasePresenter', require('src.app.ModuleBase'))

function target:model( name )
	return self:getApp():model(name)
end

function target:build(view)
	self:definition(':build(view)')
	return self
end

function target:prepare()
	self:definition(':prepare()')
end

function target:clear()
	self:definition(':clear()')
end

return target