import('..comm.HallDataDef')
local mc = import('..comm.HallDef')
local Base = import('.interface.PlayerModel')
local target = cc.load('form').build('PlayerModel', Base)

local TAG
if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')
local DeviceUtils = DeviceUtils:getInstance()


function target:update( cdata, ctype )
	local handler = {
		LOGON_SUCCEED = true,
		USER_GAMEINFO_MB = true,
		SAFE_DEPOSIT = true
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
		info.protected = cdata.bHaveSecurePwd
	end

	handler = handler[ctype]
	return handler and handler()
end

local updateGameCash = function( self ) end -- 更新游戏信息，保险箱信息
function target:prepare()
	local hall = self.hall
	TAG = hall.TAG

	local config = self:getConfig('hall').config
	local user = config.user

	self.UPDATE_PARAMS = {GameInfo = true, SafeBox = true}
	table.merge(self:user(), user)
	local function proc( client )
		local REQUEST, reqData
		local _, resp, data, result
		REQUEST = mc.LOGON_USER
		reqData = self:genDataREQ('LOGON_USER', {
				handler = {Base.fillCommonData, Base.fillDeviceData, self.fillLogonData},
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
		updateGameCash(self, client)
		self:done()
	end
	MCClient:rpcall(TAG, proc)
	self:log(':prepare().over')
end

function updateGameCash( self, client ) -- 更新游戏信息，保险箱信息
	local REQUEST, reqData, info
	local _, resp, data, result
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
	info = self.UPDATE_PARAMS.GameInfo
	if type(info)~= 'table' then
		self.UPDATE_PARAMS.GameInfo = {REQUEST, reqData}
	end

	REQUEST = mc.QUERY_SAFE_DEPOSIT
	local reqData = self:genDataREQ('QUERY_SAFE_DEPOSIT', {
			handler = {self.fillCommonData, self.fillDeviceData},
			nUserID = self:user().id
			})
	_, resp, data = client:syncSend(REQUEST, reqData)

	result = self:routine(resp, REQUEST, function (event, msg, result)
		result = self.resolve('SAFE_DEPOSIT', data)
		self:update(result, 'SAFE_DEPOSIT') -- 更新保险箱信息

		self.info.Cashbox = result
		return self.handler.QUERY_SAFE_DEPOSIT, result
	end)
	info = self.UPDATE_PARAMS.Cashbox
	if type(info)~= 'table' then
		self.UPDATE_PARAMS.Cashbox = {REQUEST, reqData}
	end
end

function target:fillUserData(desc)
	local user = self:user()
	local fill = {
		nUserID = user.id,
		nUserType = user.type,
		nNickSex = user.sex,
		nPortrait = user.portrait,
		nClothingID = user.clothing,
		nMemberLevel = user.vip,
		szUsername = self:string(user.name, 'raw'),
		szUniqueID = self:string(user.uniqueid, 'raw')
	}
	table.merge(desc, fill)
	return desc
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
	local function reqQuery(self)
		MCClient:client(TAG):send(REQUEST, reqData, handler(self, self.onGameInfoUpdate))
	end
	info.timer = self:timerScheduler(interval, reqQuery)
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


function target:updateCashbox( interval )
	local result
	local info = self.UPDATE_PARAMS.Cashbox
	local REQUEST, reqData = unpack(info)
	local function reqQuery(self)
		MCClient:client(TAG):send(REQUEST, reqData, handler(self, self.onSafeboxQuery))
	end
	info.timer = self:timerScheduler(interval, reqQuery)
	reqQuery(self)
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
	timer = timer and self:timerStop(info.timer)
	if info then info.timer = nil end
	self:off(self.handler.QUERY_SAFE_DEPOSIT)
end

function target:clear()
	Base.clear(self)
	for k,update in pairs(self.UPDATE_PARAMS) do
		local timer = update.timer
		timer = timer or self:timerStop(timer)
	end
	self.UPDATE_PARAMS = {}
end

function target:updateGameCash()
	local function proc( client )
		updateGameCash(self, client)
	end
	MCClient:rpcall(TAG, proc)
end

function target:reqTransferDeposti( amount, callback ) -- callback(info, res)
	local REQUEST, reqData
	REQUEST = mc.TRANSFER_DEPOSIT
	reqData = self:genDataREQ('TRANSFER_DEPOSIT', {
		handler = {self.fillUserData, Base.fillCommonData},
		nDeposit = amount
		})
	MCClient:client(TAG):send(REQUEST, reqData
		, function ( client, resp, data )
			local event, result
			result = self:routine(resp, REQUEST, function (event2, msg, result)
				self:log('reqTransferDeposti( amount, callback )#', amount, '.', event )
				self:nextSchedule(self.updateGameCash)
				event = event2
			end)
			callback(self.info, event)
	end)
end

local KeyResult_calc  = function(nRndKey, password)end
function target:reqTakeDeposti( amount, callback )
	local info = self.info
	local client = MCClient:client(TAG)
	local REQUEST, reqData, result, event
	local function reqTakeDeposti( ... )
		REQUEST = mc.TAKE_BACKDEPOSIT
		reqData = self:genDataREQ('TAKE_BACKDEPOSIT', {
			handler = {self.fillUserData, Base.fillCommonData},
			nDeposit = amount,
			nKeyResult = info.KeyResult,
			})
		client:send(REQUEST, reqData
			, function ( client, resp, data )
			result = self:routine(resp, REQUEST, function (event2, msg, result)
				self:log('reqTakeDeposti( amount, callback )#', amount, '.', event )
				self:nextSchedule(self.updateGameCash)
				event = event2
			end)
			callback(info, event)
		end)
	end
	if not info.protected then
		return reqTakeDeposti()
	end

	local co -- coroutine for secured password input, calculate
	local function reqRandKey( ... )
		if type(info.rndkey)~= 'number' then
			REQUEST = mc.GET_RNDKEY
			reqData = self:genDataREQ('GET_RNDKEY', {
				handler = {self.fillUserData, Base.fillCommonData},
				nRegisterGroup = 0,
				})
			client:send(REQUEST, reqData
				, function ( _, resp, data )
				result = self:routine(resp, REQUEST, function (event, msg, result)
					cdata = self.resolve('GET_RNDKEY_OK', data)
					info:_randkey(cdata.nRndKey)
				end)
			end)
		end
		self.nextSchedule(function ( ... )
			info:_randkey(info.rndkey)
		end)
	end
	co = coroutine.create(function( ... )
		if info.KeyResult==nil then
			function info:_return(password)
				self._password = password
				coroutine.resume(co, password)
			end
			function info:_randkey(rkey)
				self.rndkey = rkey
				coroutine.resume(co, rkey)
			end
			function info:calculate()
				if (self.ready) then
					local password = self._password
					if type(self.rndkey)=='number' 
					and password~=nil 
					and password ~= '' then
						self.KeyResult = KeyResult_calc(self.rndkey, password)
					end
					self.calculate = nil
					self._return = nil
					self._password = nil
					self.ready = nil
					return true
				end
				self.ready = true
				return false
			end
			reqRandKey()
			local pass = coroutine.yield(info)
			self:log('coroutine.yield(info) >>>#', tostring(pass))
			repeat
				pass = info:calculate()
				if not pass then 
					local pass_= coroutine.yield(info)
					self:log('coroutine.yield(info) >>>#', tostring(pass_))
				end
			until pass
		end
		if type(info.KeyResult) == 'number' then
			reqTakeDeposti()
		end
	end)
	local code, param = coroutine.resume(co)
	if param._return then
		callback(param, '_return')
	end

end

local MIN_SECUREPWD_LEN = 8
local DEF_SECUREPWD_LEN = 16
function KeyResult_calc(nRndKey, password)
	local len = string.len(password)
    if (MIN_SECUREPWD_LEN > len or len  > DEF_SECUREPWD_LEN) then
        return -1
    end

    local nResult = 0

    local a = math.modf(nRndKey / 10000, 1)
    local b = math.modf(nRndKey % 10000, 1)

    nResult = a + b
    local str = password
    while (str:len() >= MIN_SECUREPWD_LEN / 2) do
        local add = str:sub(0, MIN_SECUREPWD_LEN / 2)
        local key = math.modf(checknumber(add), 1)
        nResult = nResult + key
        str = str:sub(MIN_SECUREPWD_LEN / 2 + 1)
    end
    if (str:len() > 0) then
        local key = math.modf(checknumber(str), 1)
        nResult = nResult + key
    end
    return nResult
end

return target