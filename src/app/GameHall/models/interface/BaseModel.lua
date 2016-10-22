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
	raw = raw or 'utf8'
	local handler = {utf8 = true, raw = true}
	function handler.utf8( ... )
		raw = ffi.string(str)
		return MCCharset:gb2Utf8String(raw, string.len(raw))
	end
	function handler.raw( ... )
		return MCCharset:utf82GbString(str, string.len(str))
	end

	handler = handler[raw]
	return handler and handler()
end

function target:getApp()
	return self.app_
end


function target:init( app )
	self.app_ = app
	return self
end

return target