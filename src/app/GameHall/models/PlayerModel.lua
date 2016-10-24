import('..comm.HallDataDef')
local mc = import('..comm.HallDef')
local target = cc.load('form').build('PlayerModel', import('.interface.PlayerModel'))
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

local TAG
if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')
local ffi2 = MCClient.utils

function target:prepare()
	TAG = self.hall.TAG or 'Hall'

	local config = self:getConfig('hall').config
	local user = config.user

	local function proc( client )
		local _, resp, data, result, event, msg
		_, resp, data = client:syncSend(mc.LOGON_USER
			, self:requestData('LOGON_USER', {
				handler = {self.fillCommonData, self.fillDeviceData},
				szUsername = self:string(user.name, 'raw'),
				szPassword = self:string(user.password, 'raw')
				}))
	end
--	MCClient:rpcall(TAG, proc)
	self:log(':prepare().over')
end

return target