local Base = require('src.app.ModuleBase')
local target = cc.load('form').build('BaseModel', Base)

target.CONNECTION = 'CONNECTION'
target.MODEL_READY = 'READY'
target.EVENT_EXCEPTION_BREAK = 'EXCEPTION_BREAK'
target.EVENT_SHOWTIP = 'EVENT_SHOWTIP'
target.status = {}

function target:state(name, set)
	local status = self.status
	assert(type(name)=='string', 'target:state(name, set)#name except a string')
	if type(set) == 'boolean' then
		status[name] = set
		return self
	end
	return status[name] or false
end

function target:init( app )
	Base.init(self, app)
	cc.bind(self, 'event')
	return self
end

function target:on(eventName, listener, tag)
	return self:addEventListener(eventName, listener, tag)
end

function target:off( eventName )
	return self:removeEventListenersByEvent(eventName)
end

function target:regardless( tag )
	return self:removeEventListenersByTag(tag)
end

function target:done(value)
	self:dispatchEvent({
		name = self.MODEL_READY,
		value = value
		})
end
function target:exception( value )
	self:dispatchEvent({
		name = self.EVENT_EXCEPTION_BREAK,
		value = value
		})
	return self
end

--[[
function target:string( str ) -- overload]]
function target:string( str, raw ) -- raw = 'raw'; make cdata become a lua string encoded with UTF8
end

function target:fillCommonData(desc)
	self:log(':fillCommonData(desc)')
end

function target:fillDeviceData(desc)
	self:log(':fillDeviceData(desc)')
end

function target:genDataREQ( ctype, desc ) -- 生成序列化请求数据
--[[
	desc = {handler = {target.fillCommData, 'int'}, affect = false}
	-- affect field `dwGetFlags`
--]]
	self:log(':genDataREQ( ctype, desc )')
end

--[[
function target.resolve( resp, reference )	-- overload #1:number
function target.resolve( body )			-- overload #1:table
function target.resolve( ctype, {cfield, ctype, data} ) -- overload #1:string, #2:table
function target.resolve( ctype, data )	-- overload #1:string, #2:cdata]]
function target.resolve( ... )
	self:log('.resolve( ... )')
end

--[[
function target:routine( resp, {REQUEST, reference}, func ) -- overload]]
function target:routine( resp, REQUEST, func )
	self:log(':routine( resp, REQUEST, func )')
end

return target