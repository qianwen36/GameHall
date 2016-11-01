local Base = import('..BasePresenter')
local target = cc.load('form').build('SafeBox', Base)

local DEFAULT_INTERVAL = 60
function target:getConfig( name ) -- method override
	local config = self.config
	if (config == nil) then
		config = Base.getConfig(self)
		self.config = config
	end
	if name ~= nil then
		local res = {
		interval = config.refresh.cashbox or DEFAULT_INTERVAL,
		}
		return res[name] or config[name]
	end
	return config
end

function target:build( view )
	self.view = view
	if (self.player == nil) then
		self.player = self:model('PlayerModel')
	end
	return self:ready(view)
end

function target:prepare(view)
	local player = self.player
	if view then
		local EVENT_NAME, tagEvent
		EVENT_NAME = player.handler.QUERY_SAFE_DEPOSIT
		tagEvent = self:tagEvent(EVENT_NAME) 
		player:on(EVENT_NAME, handler(self, self.onSafeDepositQuery), tagEvent)

		EVENT_NAME = player.handler.QUERY_USER_GAMEINFO
		tagEvent = self:tagEvent(EVENT_NAME) 
		player:on(EVENT_NAME, handler(self, self.onUserGameinfoQuery), tagEvent)

		self:onUserGameinfoQuery()
	else
		player:updateCashbox(self:getConfig('interval'))
	end
end

function target:onSafeDepositQuery()
	local info = self.player.info
	self.view:refresh('safebox', info.cashbox)
end
function target:onUserGameinfoQuery()
	local info = self.player:user()
	self.view:refresh('gamedeposit', info.deposit)
end

function target:clear()
	local player = self.player
	local EVENT_NAME, tagEvent
	EVENT_NAME = player.handler.QUERY_SAFE_DEPOSIT
	tagEvent = self:tagEvent(EVENT_NAME) 
	player:regardless(tagEvent)

	player:pauseCashBox()

	EVENT_NAME = player.handler.QUERY_USER_GAMEINFO
	tagEvent = self:tagEvent(EVENT_NAME) 
	player:regardless(tagEvent)
end

function target:save( amount )
	local res = self.player:reqTransferDeposti(amount
		, function ( info, res )
			local handler = {succeed = true, failed = true}
			function handler.succeed( ... )
			end
			function handler.failed( ... )
			end
			handler = handler[res]
			return handler and handler()
		end)
end
function target:take( amount )
	local res = self.player:reqTakeDeposti(amount
		, function ( info, res )
			if type(info[res])=='function' then
				self.view:promptPassword(handler(info, info[res]))
			else
				local handler = {succeed = true, failed = true}
				function handler.succeed( ... )
				end
				function handler.failed( ... )
				end
				handler = handler[res]
				return handler and handler()
			end
		end)
end

return target