local target = cc.load('form').build('PlayerModel.interface', import('.HallSpread'))

target.handler = {
	LOGON_SUCCEED = 'LOGON_SUCCEED',
	QUERY_USER_GAMEINFO = 'QUERY_USER_GAMEINFO'
}

function target:update( cdata, ctype )
	self:definition(':update( cdata, ctype )')
end

return target