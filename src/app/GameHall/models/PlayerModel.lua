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
	local info = self.info
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
	function handler.SAFE_DEPOSIT( ... )
		info.cashbox = cdata.nDeposit
		info.secure = cdata.bHaveSecurePwd
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
		local _, resp, data, REQUEST, reqData, result
		REQUEST = mc.LOGON_USER
		reqData = self:genDataREQ('LOGON_USER', {
				handler = {self.fillCommonData, self.fillDeviceData, self.fillLogonData},
				szUsername = self:string(user.name, 'raw'),
				szPassword = self:string(user.password, 'raw')
				})
		_, resp, data = client:syncSend(REQUEST, reqData)

		result = self:routine(resp, {REQUEST, mc.LOGON_SUCCEEDED}, function (event, msg, result)
			result = self.resolve('LOGON_SUCCEED', data)
			self:update(result, 'LOGON_SUCCEED') -- 更新用户信息

			self.info.LOGON = result
			return self.handler.LOGON_SUCCEED, result
		end)
		if result == false then return end
		REQUEST = mc.QUERY_USER_GAMEINFO
		reqData = self:genDataREQ('QUERY_USER_GAMEINFO', {
				handler = {self.fillCommonData, self.fillDeviceData},
				nUserID = self:user().id
				})
		_, resp, data = client:syncSend(REQUEST, reqData)

		result = self:routine(resp, REQUEST, function (event, msg, result)
			result = self.resolve('USER_GAMEINFO_MB', data)
			self:update(result, 'USER_GAMEINFO_MB') -- 更新用户信息

			self.info.GAME = result
			return self.handler.QUERY_USER_GAMEINFO, result
		end)
		if result == false then return end
		self.UPDATE_PARAMS = {GameInfo = {REQUEST, reqData},}
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

function target:updateGameInfo( interval )
	local info = self.UPDATE_PARAMS.GameInfo
	local REQUEST, reqData = unpack(info)
	local timer = Scheduler:scheduleScriptFunc(function ( ... )
		MCClient:client(TAG):send(REQUEST, reqData, handler(self, self.onGameInfoUpdate))
	end, interval, false)
	info.timer = timer
end

function target:onGameInfoUpdate( client, resp, data )
	local result
	local REQUEST, reqData = unpack(self.UPDATE_PARAMS.GameInfo)
	result = self:routine(resp, REQUEST, function (event, msg, result)
		result = self.resolve('USER_GAMEINFO_MB', data)
		self:update(result, 'USER_GAMEINFO_MB') -- 更新用户信息

		self.info.GAME = result
		return self.handler.QUERY_USER_GAMEINFO, result
	end)
end


function target:Params4Cashbox()
	local info = self.UPDATE_PARAMS.Cashbox
	if (info == nil) then
		local reqData = self:genDataREQ('QUERY_SAFE_DEPOSIT', {
				handler = {self.fillCommonData, self.fillDeviceData},
				nUserID = self:user().id
				})
		info = {mc.QUERY_SAFE_DEPOSIT, reqData}
		self.UPDATE_PARAMS.Cashbox = info
	end
	return info
end
function target:updateCashbox( interval )
	local result
	local info = self:Params4Cashbox()
	local REQUEST, reqData = unpack(info)
	local function reqQuery()
		MCClient:client(TAG):send(REQUEST, reqData, handler(self, self.onSafeboxQuery))
	end
	local timer = Scheduler:scheduleScriptFunc(function ( ... )
		reqQuery()
	end, interval, false)
	info.timer = timer
	reqQuery()
end
function target:onSafeboxQuery( client, resp, data )
	local result
	local REQUEST, reqData = unpack(self.UPDATE_PARAMS.Cashbox)
	result = self:routine(resp, REQUEST, function (event, msg, result)
		result = self.resolve('SAFE_DEPOSIT', data)
		self:update(result, 'SAFE_DEPOSIT') -- 更新用户信息

		self.info.Cashbox = result
		return self.handler.QUERY_SAFE_DEPOSIT, result
	end)
end

function target:pauseCashBox()
	local info = self.UPDATE_PARAMS.Cashbox
	local timer = info and info.timer
	timer = timer and Scheduler:unscheduleScriptEntry(info.timer)
	if info then info.timer = nil end
	self:off(self.handler.QUERY_SAFE_DEPOSIT)
end

function target:clear()
	Base.clear(self)
	for k,update in pairs(self.UPDATE_PARAMS) do
		Scheduler:unscheduleScriptEntry(update.timer)
	end
	self.UPDATE_PARAMS = {}
end

return target