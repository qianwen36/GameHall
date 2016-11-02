local target = cc.load('form').build('PlayerModel.interface', import('.HallSpread'))

target.handler = {
	LOGON_SUCCEED = 'LOGON_SUCCEED',
	QUERY_USER_GAMEINFO = 'QUERY_USER_GAMEINFO',
	QUERY_SAFE_DEPOSIT = 'QUERY_SAFE_DEPOSIT',
	GET_RNDKEY = 'GET_RNDKEY',
}

function target:reset()
	self.info = {
		GAME = nil,	-- cdata<LOGON_SUCCEED>
		LOGON= nil,	-- cdata<USER_GAMEINFO_MB>
		KeyResult = nil,
		cashbox = true,
		rndkey = true,
		protected = false,
		deposit = true,
	}
	self:spec('user', {
		name = true,
		type = true,
		id = true,		-- userid
		sex = true,
		portrait = true,-- 形象
		clothing = true,
		uniqueid = true,
		nick = true,	-- 昵称
		vip = true,		-- 会员等级
		deposit = true,	-- 游戏银两
		score = true,	-- 游戏积分
		experience = true,
		level = true,	-- 玩家级别
		})
end

function target:updateGameInfo( interval )
	self:definition(':updateGameInfo( interval )')
end

function target:updateCashbox( interval )
	self:definition(':updateCashbox( interval )')
end

function target:pauseCashBox()
	self:definition(':pauseCashBox()')
end

function target:reqTransferDeposit( amount, callback ) -- callback(info, res)
	self:definition(':reqTransferDeposti( amount, callback )')
end

function target:reqTakeDeposit( amount, callback )
	self:definition(':reqTakeDeposti( amount, callback )')
end
return target