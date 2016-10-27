local target = cc.load('form').build('BasePresenter', require('src.app.ModuleBase'))

function target:model( name )
	return self:getApp():model(name)
end

return target