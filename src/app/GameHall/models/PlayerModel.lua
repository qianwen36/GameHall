local target = cc.load('form').build('PlayerModel', import('.interface.PlayerModel'))

function target:login( hall )
	hall:login()
end

return target