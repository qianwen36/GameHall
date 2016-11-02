local Base = import('.BasePresenter')
local target = cc.load('form').build('UserProfile', Base)

local DEFAULT_INTERVAL = 60

function target:getConfig( name ) -- method override
	local config = self.config
	if (config == nil) then
		config = Base.getConfig(self)
		self.config = config
	end
	if name ~= nil then
		local res = {
		interval = config.refresh.gameinfo or DEFAULT_INTERVAL,
		}
		return res[name] or config[name]
	end
	return config
end

function target:build( view )
	self.view = view
	
	if (self.player == nil) then
		self.player = self:model('PlayerModel')
		local player = self.player
		player:on(player.MODEL_READY, handler(self, self.onProfileReady))
		player:on(player.EVENT_EXCEPTION_BREAK, handler(self, self.onCommunicationBreak))
		player:on(player.handler.LOGON_SUCCEED, handler(self, self.onLogon))
		player:on(player.handler.QUERY_USER_GAMEINFO, handler(self, self.onGameInfoUpdate))
	end

	return Base.build(self, view)
end

function target:onCommunicationBreak( event )
	local value = event.value
	self.view:showToast('['..value.event..']*'..value.msg, 3)
end

function target:onProfileReady( event )
	Base.ready(self, self.view)
	self.player:updateGameInfo(self:getConfig('interval'))
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