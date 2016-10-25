import('..comm.HallDataDef')
local mc = import('..comm.HallDef')
local target = cc.load('form').build('PlayerModel', import('.interface.PlayerModel'))
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

local TAG
if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')
local ffi2 = MCClient.utils

target.infoLogon = nil	-- cdata<LOGON_SUCCEED>
target.infoGame = nil 	-- cdata<USER_GAMEINFO_MB>
function target:prepare()
	local hall = self.hall
	TAG = hall.TAG

	local config = self:getConfig('hall').config
	local user = config.user

	local function proc( client )
		local _, resp, data, REQUEST, result
		REQUEST = mc.LOGON_USER
		_, resp, data = client:syncSend(REQUEST
			, self:genDataREQ('LOGON_USER', {
				handler = {self.fillCommonData, self.fillDeviceData, self.fillLogonData},
				szUsername = self:string(user.name, 'raw'),
				szPassword = self:string(user.password, 'raw')
				}))
		result = self:routine(resp, REQUEST, function (event, msg, result)
			return self.handler.LOGON_SUCCEED, self.resolve('LOGON_SUCCEED', data)
		end)
		if result == false then return end
		self.infoLogon = result
		self:update(result) -- 更新用户信息
		
		REQUEST = mc.QUERY_USER_GAMEINFO
		_, resp, data = client:syncSend(REQUEST
			, self:genDataREQ('QUERY_USER_GAMEINFO', {
				handler = {self.fillCommonData, self.fillDeviceData},
				nUserID = self:user().id
				}))
		result = self:routine(resp, REQUEST, function (event, msg, result)
			return self.handler.USER_GAMEINFO_MB, self.resolve('USER_GAMEINFO_MB', data)
		end)
		if result == false then return end
		self.infoGame = result
		self:update(result) -- 更新用户信息
	end
--	MCClient:rpcall(TAG, proc)
	self:log(':prepare().over')
end

function target:fillLogonData(desc)
	local config = self:getConfig('hall').config
	local major, minor, buildno = config:getVersion()
	local flags = mc.Flags.FLAG_LOGON_INTER
	if (DeviceUtils:isSimulator()) then
		flags = bit.bor(flags, mc.Flags.FLAG_LOGON_SIMULATOR)
	end

	local fill = {
		nGroupType = mc.ext.GROUP_TYPE_DEFAULT,
		dwLogonFlags = flags,
		nHallBuildNO = buildno,
		dwGameVer = bit.bor(major*(2^16), minor),
	}
	table.merge(desc, fill)
	return desc
end

return target