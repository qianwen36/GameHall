local target = cc.load('form').build('PlayerModel', import('.interface.PlayerModel'))

function target:prepare()
	local hall = self.hall
end

return target