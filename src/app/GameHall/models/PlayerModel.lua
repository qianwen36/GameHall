import('..comm.HallDataDef')
local mc = import('..comm.HallDef')
local target = cc.load('form').build('PlayerModel', import('.interface.PlayerModel'))
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

local TAG
if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')
local ffi2 = MCClient.utils
local DeviceUtils = DeviceUtils:getInstance()

target.info ={
	GAME = nil,	-- cdata<LOGON_SUCCEED>
	LOGON= nil 	-- cdata<USER_GAMEINFO_MB>
}
function target:clear()
	self.info = {}
	self:spec('user', {
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

function target:update( cdata, ctype )
	local handler = {
		LOGON_SUCCEED = true,
		USER_GAMEINFO_MB = true,
	}
	local user = self:user() or {}
	function handler.LOGON_SUCCEED( ... )
		user.type = cdata.nUserType
		user.id = cdata.nUserID
		user.sex = cdata.nNickSex
		user.vip = cdata.nMemberLevel
		user.portrait = cdata.nPortrait
		user.clothing = cdata.nClothingID
		user.uniqueid = self:string(cdata.szUniqueID)
		user.nick = self:string(cdata.szNickName)
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
			return self.handler.LOGON_SUCCEED, self.resolve('LOGON_SUCCEED', data)
		end)
		if result == false then return end
		self.info.LOGON = result
		self:update(result, 'LOGON_SUCCEED') -- 更新用户信息
		
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
		self.info.GAME = result
		self:update(result, 'USER_GAMEINFO_MB') -- 更新用户信息
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