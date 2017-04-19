import('..comm.HallDataDef')
local Base = import('.interface.RoomModel')
local target = cc.load('form').build('RoomModel', Base)
local mc = import('..comm.HallDef')

local handler_ = {
	GET_AREAS	= 'GET_AREAS',
	GET_ROOMS	= 'GET_ROOMS',
	GET_NEWTABLE = 'GET_NEWTABLE',
	UPDATE_ROOMUSERSCOUNT = 'UPDATE_ROOMUSERSCOUNT'
}
--table.merge(target.handler, handler)

local TAG = {hall = nil, room = target.TAG}
if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')

function target:offline(name)
	local info = self:getApp():getConfig('hall').offline or {}
	return info[name]
end

local function onGetAreas(self, event)
	local array = self.resolve(event.value)
	for i,info in ipairs(array) do
		local cdata = info.data
		info.id = cdata.nAreaID
		info.name = self:string(cdata.szAreaName)
		info.type = cdata.nAreaType
		info.subtype = cdata.nSubType
		info.icon = cdata.nIconID
		info.status = cdata.nStatus
		info.layorder = cdata.nLayOrder
		info.fontcolor = cdata.nFontColor
		info.gift = cdata.nGifID
		info.rooms = {}
	end
	local info = self:offline('area')
	if (info~=nil) then
		info.rooms = {self:offline('room')}
		table.insert(array, 1, info)
	end

	self:areas(array)
end
local function onGetRooms(self, event)
	local array = self.resolve(event.value)
	if array and #array >0 then
		local info = array[1].data
		local id = info and info.nAreaID

		local area = self:areainfo(id)
		for i,info in ipairs(array) do
			local cdata = info.data
			local type_ = (bit.band(cdata.dwOptions, mc.Flags.ROOM_OPT_NEEDDEPOSIT) and 'deposit') or 'score'
			local condition = {score = cdata.nMinScore, deposit = cdata.nMinDeposit}
			info.area = area
			info.id = cdata.nRoomID
			info.name = self:string(cdata.szRoomName)
			info.type = cdata.nRoomType
			info.subtype = cdata.nSubType
			info.icon = cdata.nIconID
			info.status = cdata.nStatus
			info.layorder = cdata.nLayOrder
			info.fontcolor = cdata.nFontColor
			info.gift = cdata.nGifID
			info.type2 = type_
			info.condition = condition[type_]
		end
		area.rooms = array
		local rooms = self:rooms()
		table.insertto(rooms, array, #rooms+1)
	else -- failed
	end
end
local function onReady( self, event )
	local value = event.value
	local handler = {HALL_READY = true, ROOM_READY = nil}
	function handler.HALL_READY( ... )
		self:off(handler_.GET_AREAS)
		self:off(handler_.GET_ROOMS)

		local info = self:offline('room')
		if info~=nil then
			local array = self:rooms()
			table.insert(array, 1, info)
			if (info.data == nil) then
				info.data = {
				szGameIP = '127.0.0.1',
				nGamePort = 21568,
				nPort = 0,
				nAreaID = 1434,
				nRoomID = 5360,
				nGameVID = 1005680000,
				}
			end
		end
	end
	handler = handler[value.event]
	return handler and handler()
end

function target:areainfo( id )
	local array = self:areas()
	for i,info in ipairs(array) do
		if id == info.id then
			return info
		end
	end
end

function target:roominfo( id )
	local array = self:rooms()
	for i,info in ipairs(array) do
		if id == info.id then
			return info
		end
	end
end

local function onRoomOnlineuserUpdate( self, event )
	local array = self.resolve(event.value)
	for i,info in ipairs(array) do
		info = info.data
		local room = self:roominfo(info.nItemID) or {}
		local c = info.nUsers
		room.online = c
	end
	local function online_count( array )
		local c = 0
		for i,info in ipairs(array) do
			c = c + info.online
		end
		return c
	end
	array = self:areas()
	for i,info in ipairs(array) do
		info.online = online_count(info.rooms)
	end
	self:dispatchEvent({
		name = self.handler.ONLINE_USERS_UPDATE,
		})
end

function target:prepare()
	local hall = self.hall
	TAG.hall = hall.TAG
	self:on(self.MODEL_READY, handler(self, onReady), self:tagEvent(self.MODEL_READY))
	self:on(handler_.GET_AREAS, handler(self, onGetAreas))
	self:on(handler_.GET_ROOMS, handler(self, onGetRooms))
	self:on(handler_.UPDATE_ROOMUSERSCOUNT, handler(self, onRoomOnlineuserUpdate))
	local function proc( client )
		local _, resp, data, REQUEST, result
		-- 获取大区列表
		REQUEST = mc.GET_AREAS
        local flags = mc.Flags.FLAG_GETAREAS_MOBILE
--        if DEBUG~=0 then flags = flags + mc.Flags.FLAG_GETAREAS_INCLUDE_HIDE end
		_, resp, data = client:syncSend(REQUEST
			, self:genDataREQ('GET_AREAS', {handler = self.fillCommonData,
                dwGetFlags = flags})
                )

		result = self:routine(resp, REQUEST, function (event, msg, result)
			return handler_.GET_AREAS, self.resolve('AREAS', {'nCount', 'AREA', data})
		end)
		if result == false then return end

		local ar = result or {}
		local count = ar[1] or 0
		for i=0, count-1 do
			local info = ar[2][i]
			REQUEST = mc.GET_ROOMS
		    _, resp, data = client:syncSend(REQUEST
		    	, self:genDataREQ('GET_ROOMS'
		    		, {handler = self.fillCommonData
		    		, nAreaID = info.nAreaID}) )

		    result = self:routine(resp, REQUEST, function (event, msg, result)
		    	return handler_.GET_ROOMS, self.resolve('ROOMS', {'nRoomCount', 'ROOM', data})
		    end)
			if result == false then return end
		end
		self:state('ready', true)
		self:done({event = self.HALL_READY})
	end
	MCClient:rpcall(TAG.hall, proc)
	self:log(':prepare().over')
end

local socket_resolve = function ( cdata )end -- ctype<ROOM>
local socket_resolve2= function ( cdata )end -- ctype<ROOM>
local enterRoomREQ = function(self, info)end -- return desc
local getTableREQ = function (self, info)end -- return desc

function target:quit(param)
    local reqData = self:genDataREQ('LEAVE_ROOM', param)
    MCClient:client(TAG.room)
            :send(mc.LEAVE_ROOM , reqData, function (client, respondId, data)
		self:nextSchedule(self.finish)
    end)
end

function target:finish()
	MCClient:destroy(TAG.room)
	self:state('connected', false)
	self:state('entering', false)
end
function target:establish( info )
	local connected = self:state('connected')
	if not connected and
	not self:state('entering') then
		self:state('entering', true)
		local host, port = socket_resolve(info.data)
		MCClient:connect(host, port, TAG.room, function(client, resp)
			local result = self:routine(resp, self.EVENT_CONNECTION
				, function ( event, msg, result )
					self:nextSchedule(self.enterRoom, info)
					return self.CONNECTION, TAG
				end)
				self:state('connected', result==TAG)
				if not result then
					self:nextSchedule(self.finish)
				end
				self:state('entering', false)
		end)
	end
	return connected
end
function target:enterRoom( info ) -- roominfo
	local function cleanup()
		self:nextSchedule(self.finish)
	end
	if self:establish(info) and
	not self:state('entering') then
		self:state('entering', true)
		local _, resp, data
		-- enter room
		-- get a table
		local function needaTable(cdata)
			return cdata.nTableNO == -1 or cdata.nChairNO == -1
		end
		local function enterRoomOK(event, msg, result)
			return self.handler.ENTER_ROOM, self.resolve('EnterRoomCompletion', data)
		end
		local function yetEnterRoom( event, msg, result )
			local id = self.resolve('int', data)
			local info = self:roominfo(id)
			cleanup()
			self:nextSchedule(self.enterRoom, info)
		end
		local function needUpdateZIP( event, msg, result )
			self:log('needUpdateZIP()#msg=', msg)
		end

		local function needUpdateAPK( event, msg, result )
			self:log('needUpdateAPK()#msg=', msg)
		end
		
		local function tipUpgrade( event, msg, result )
			self:log('tipUpgrade()#msg=', msg)
		end

		local handler = {
			ENTER_ROOM_OK = enterRoomOK, 
			ENTER_CLOAKINGROOM_OK = enterRoomOK,
			ROOM_NEED_DXXW = yetEnterRoom,
			OLD_EXEMINORVER = needUpdateZIP,
			OLD_EXEMAJORVER = needUpdateZIP,
			OLD_EXEBUILDNO = needUpdateZIP,
			NEW_EXEMAJORVER = tipUpgrade,
			NEW_EXEMINORVER = tipUpgrade,
			NEW_EXEBUILDNO = tipUpgrade,
			OLD_HALLBUILDNO = needUpdateAPK,
			NEW_HALLBUILDNO = needUpdateAPK,
		}
		local co, params -- params{enterRoomInfo, playerInfo, tableInfo}
		local REQUEST, reqData, result
		
		co = MCClient:rpcall(TAG.room, function ( client )
			local desc
			REQUEST = mc.ENTER_ROOM
			desc = enterRoomREQ(self, info)
			reqData = self:genDataREQ('ENTER_ROOM', desc)
	
			_, resp, data = client:syncSend(REQUEST, reqData )
			result = self:routine(resp, REQUEST, handler)
			if not result then return cleanup() end
			local host, port = socket_resolve2(info.data)
			params = {
				roomData = info.data,
				enterRoomInfo = result.enterRoomInfo,
				playerInfo = result.playerInfo,
				deviceInfo = self:fillDeviceData({}),
				host = host,
				port = port,
			}

			if needaTable(result.playerInfo) then
				REQUEST = mc.GET_NEWTABLE
				desc = getTableREQ(self, info)
				reqData = self:genDataREQ('GET_NEWTABLE', desc)
	
				_, resp, data = client:syncSend(REQUEST, reqData )
				result = self:routine(resp, REQUEST, function (event, msg, result)
					return handler_.GET_NEWTABLE, self.resolve('NTF_GET_NEWTABLE', data)
				end)
				if not result then return cleanup() end
				params.tableInfo = result
			end
			self:state('entering', false)
			self:done({event = self.ROOM_READY, msg = 'ready for GameScene', result = params})
		end)
		self:log('MCClient:rpcall(TAG, proc) >>>#co=', tostring(co))
	end

end

function enterRoomREQ(self, info)
	local desc = MCClient.table4s(info.data, {
		'nAreaID',
		'nGameID',
		'nGameVID',
		'nRoomID',
		'nExeMajorVer',
		'nExeMinorVer',
		-- 'nExeBuildno'
		})
	local player = self:getApp():model('PlayerModel')
	desc.handler = {{player.fillUserData, player}, self.fillCommonData, self.fillDeviceData}

	return desc
end
function getTableREQ(self, info)
	local desc = MCClient.table4s(info.data, {
		'nRoomID',
		'nAreaID',
		'nGameID',
		})
	local player = self:getApp():model('PlayerModel')
	desc.handler = {{player.fillUserData, player}, self.fillCommonData}

	return desc
end
function socket_resolve( info )
	local host, port = target:string(info.szGameIP), info.nPort
	if (port == 0) then
		port = 31629
	else
		port = port + 1000
	end
	return host, tostring(port)
end
function socket_resolve2( info )
	local host, port = target:string(info.szGameIP), info.nGamePort + 20000
	return host, tostring(port)
end

function target:updateOnlineusers( param, interval )-- param:[room, ...], register and init event dispatcher
	local client = MCClient:client(TAG.hall)
	local function onNotify( _, resp, data )
		local result = self:routine(resp, {REQUEST, mc.GET_ROOMUSERS_OK}, function (event, msg, result)
			return handler_.UPDATE_ROOMUSERSCOUNT, self.resolve('ITEM_COUNT', {'nCount', 'ITEM_USERS', data})
		end)
	end
	local waiting = mc.GET_ROOMUSERS_OK
	if self.UPDATE_PARAMS then
		client:off(waiting)
	end
	client:on(waiting, onNotify)
	local timer = self:timerScheduler(interval, function ( ... )
		local data = self.UPDATE_PARAMS[1]
		client:send(mc.GET_ROOMUSERS, data)
	end)

	local data, ct = self:genDataREQ(
		'GET_ROOMUSERS', {
			handler = {self.fillCommonData, 'int'},
			affect = false,
			nRoomCount = #param,
			param
		} )
	self.UPDATE_PARAMS = {data, timer, waiting}
	client:send(mc.GET_ROOMUSERS, data)
end

function target:clear()
	Base.clear(self)
	local array = self.UPDATE_PARAMS
	if array then
		local param, timer, waiting = unpack(array)
		local client = MCClient:client(TAG.hall)
		self:timerStop(timer)
		client:off(waiting)
		self.UPDATE_PARAMS = nil
	end
	self:off(handler_.UPDATE_ROOMUSERSCOUNT)
end

return target