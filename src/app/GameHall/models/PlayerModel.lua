import('..comm.HallDataDef')
local mc = import('..comm.HallDef')
local target = cc.load('form').build('PlayerModel', import('.interface.PlayerModel'))
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

local TAG
if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')
local DeviceUtils = DeviceUtils:getInstance()

function target:update( cdata, ctype )
	local handler = {
		LOGON_SUCCEED = true,
		USER_GAMEINFO_MB = true,
	}
	local user = self:user() or {}
	function handler.LOGON_SUCCEED( ... )
		local sex = {'male', 'female'}
		user.type = cdata.nUserType
		user.id = cdata.nUserID
		user.sex = sex[cdata.nNickSex+1]
		user.vip = cdata.nMemberLevel
		user.portrait = cdata.nPortrait
		user.clothing = cdata.nClothingID
		user.uniqueid = self:string(cdata.szUniqueID)
		user.nick = self:string(cdata.szNickName)
		if (user.nick == '') then
			user.nick = user.name
		end
	end
	function handler.USER_GAMEINFO_MB( ... )
		user.deposit = cdata.nDeposit
		user.score = cdata.nScore
		user.experience = cdata.nExperience
		user.level = cdata.nPlayerLevel
	end

	handler = handler[ctype]
	return handler and handler()
end

function target:prepare()
	local hall = self.hall
	TAG = hall.TAG

	local config = self:getConfig('hall').config
	local user = config.user

	table.merge(self:user(), user)
	local function proc( client )
		local _, resp, data, REQUEST, result
		REQUEST = mc.LOGON_USER
		_, resp, data = client:syncSend(REQUEST
			, self:genDataREQ('LOGON_USER', {
				handler = {self.fillCommonData, self.fillDeviceData, self.fillLogonData},
				szUsername = self:string(user.name, 'raw'),
				szPassword = self:string(user.password, 'raw')
				}))
		result = self:routine(resp, {REQUEST, mc.LOGON_SUCCEEDED}, function (event, msg, result)
			result = self.resolve('LOGON_SUCCEED', data)
			self:update(result, 'LOGON_SUCCEED') -- 更新用户信息

			self.info.LOGON = result
			return self.handler.LOGON_SUCCEED, result
		end)
		if result == false then return end
		
		REQUEST = mc.QUERY_USER_GAMEINFO
		_, resp, data = client:syncSend(REQUEST
			, self:genDataREQ('QUERY_USER_GAMEINFO', {
				handler = {self.fillCommonData, self.fillDeviceData},
				nUserID = self:user().id
				}))
		result = self:routine(resp, REQUEST, function (event, msg, result)
			result = self.resolve('USER_GAMEINFO_MB', data)
			self:update(result, 'USER_GAMEINFO_MB') -- 更新用户信息

			self.info.GAME = result
			return self.handler.QUERY_USER_GAMEINFO, result
		end)
		if result == false then return end
		self:done()
	end
	MCClient:rpcall(TAG, proc)
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