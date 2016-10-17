local target = cc.load('form').build('PlayerModel')

function target:login( hall )
	self:message(':login( hall )')
end

return target