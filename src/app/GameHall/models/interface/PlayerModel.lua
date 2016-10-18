local target = cc.load('form').build('PlayerModel.interface')

function target:login( hall )
	self:message(':login( hall )')
end

return target