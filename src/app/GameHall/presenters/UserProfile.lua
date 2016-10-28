local target = cc.load('form').build('UserProfile', import('.BasePresenter'))

function target:build( MainScene )
	self.view = MainScene
	
	if (self.player == nil) then
		local player = self:model('PlayerModel')
		player:on(player.MODEL_READY, handler(self, self.onProfileReady))
		player:on(player.EVENT_EXCEPTION_BREAK, handler(self, self.onCommunicationBreak))
		player:on(player.handler.LOGON_SUCCEED, handler(self, self.onLogon))
		player:on(player.handler.QUERY_USER_GAMEINFO, handler(self, self.onGameInfoUpdate))
		self.player = player
	end
	if (self.ready) then
		self:prepare(MainScene)
	else
		self:prepare()
	end
	return self
end

function target:onCommunicationBreak( event )
--	self.ready = false
end

function target:onProfileReady( event )
	self.ready = true
end

local function updateUserProfile( view, info )
	view:updateProfile({
		nick = info.nick,
		sex = info.sex,
		vip = info.vip,
		})
end
local function updateGameInfo( view, info )
	view:updateGameInfo({
		deposit = info.deposit,
		score = info.score,
		level = info.level,
		experience = info.experience
		})
end

function target:onLogon( event )
	if (self.view ~= nil) then
		updateUserProfile(self.view, self.player:user())
	end
end

function target:onGameInfoUpdate( event )
	if (self.view ~= nil) then
		updateGameInfo(self.view, self.player:user())
	end
end

function target:prepare( MainScene )
	if (MainScene~= nil) then
		local info = self.player:user()
		updateUserProfile(MainScene, info)
		updateGameInfo(MainScene, info)
	else
		self.player:prepare()
	end
end

return target