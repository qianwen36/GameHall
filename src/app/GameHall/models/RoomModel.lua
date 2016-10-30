import('..comm.HallDataDef')
local Base = import('.interface.RoomModel')
local target = cc.load('form').build('RoomModel', Base)
local mc = import('..comm.HallDef')
local Director = cc.Director:getInstance()
local Scheduler = Director:getScheduler()

local handler_ = {
	GET_AREAS	= 'GET_AREAS',
	GET_ROOMS	= 'GET_ROOMS',
	UPDATE_ROOMUSERSCOUNT = 'UPDATE_ROOMUSERSCOUNT'
}
--table.merge(target.handler, handler)

local TAG = {}
if not USING_MCRuntime then return target end

local MCClient = require('src.app.TcyCommon.MCClient2')

local function onGetAreas(self, event)
	local array = self.resolve(event.body)
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
	self:areas(array)
end
local function onGetRooms(self, event)
	local array = self.resolve(event.body)
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
local function onReady( self )
	self:regardless(self:tagEvent(self.MODEL_READY))
	self:off(handler_.GET_AREAS)
	self:off(handler_.GET_ROOMS)
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
	local array = self.resolve(event.body)
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
		_, resp, data = client:syncSend(REQUEST
			, self:genDataREQ('GET_AREAS', {handler = self.fillCommonData}) )

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
			if result == false then break end
		end
		if result == false then return end
		self:done()
	end
	MCClient:rpcall(TAG.hall, proc)
	self:log(':prepare().over')
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
	local function reqRoomsUserCount(array)
		local REQUEST = mc.GET_ROOMUSERS
		local data, ct = self:genDataREQ(
			'GET_ROOMUSERS', {
				handler = {self.fillCommonData, 'int'},
				affect = false,
				nRoomCount = #array,
				array
			} )
		client:send(REQUEST, data)
	end
	local timer = Scheduler:scheduleScriptFunc(function ( ... )
		reqRoomsUserCount(self.UPDATE_PARAMS[1])
	end, interval, false)

	self.UPDATE_PARAMS = {param, timer, waiting}
	reqRoomsUserCount(param)
end

function target:clear()
	Base.clear(self)
	local array = self.UPDATE_PARAMS
	if array then
		local param, timer, waiting = unpack(array)
		local client = MCClient:client(TAG.hall)
		Scheduler:unscheduleScriptEntry(timer)
		client:off(waiting)
		self.UPDATE_PARAMS = nil
	end
	self:off(handler_.UPDATE_ROOMUSERSCOUNT)
end

return target