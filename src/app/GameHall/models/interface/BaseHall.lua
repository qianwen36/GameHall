local target = cc.load('form').build('BaseHall')

function target:start( config )
	self:message(':start( config )')
end

function target:restart()
	self:message(':restart()')
end

return target