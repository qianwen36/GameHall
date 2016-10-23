local target = cc.load('form').build('BaseModel')

cc.bind(target, 'event')

local ffi = require('ffi')
local MCCharset = MCCharset:getInstance()

function target:on(eventName, listener, tag)
	return self:addEventListener(eventName, listener, tag)
end

function target:off( tag )
	return self:removeEventListenersByTag(tag)
end

function target:string( str, raw )
	--[[
		raw = 'raw' make str UTF8 to GBK string
		raw = 'utf8' or nil make str GBK to UTF8 string
	--]]
	assert(type(raw)=='string' or raw == nil, 'target:string(str, raw) #raw expect string')


	raw = raw or 'utf8'
	local handler = {utf8 = true, raw = true}
	function handler.utf8( ... )
		str = ffi.string(str)
		local len = string.len(str)
		if len == 0 then return str end

		return MCCharset:gb2Utf8String(str, len)
	end
	function handler.raw( ... )
		local len = string.len(str)
		if len == 0 then return str end

		return MCCharset:utf82GbString(str, len)
	end

	handler = handler[raw]
	return handler and handler()
end

function target:getConfig( name )
	return self.app_:getConfig(name)
end

function target:getApp()
	return self.app_
end


function target:init( app )
	self.app_ = app
	return self
end

return target