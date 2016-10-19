local target = cc.load('form').build('PlayerModel.interface')

function target:login( hall )
	self:definition(':login( hall )')
end

return target