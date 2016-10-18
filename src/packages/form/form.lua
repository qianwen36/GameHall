local form = {_tag = 'form'}
function form.build(tag, super)
    local target = {
    	_tag = tag,
    	_super = super
    }
    form.spec(target)
    setmetatable(target, form._meta())
    return target
end

function form.on(target, spec)
    local tar = {}
    for k,v in pairs(spec) do
	    if type(v) == 'function' then
	    	local method = target[k] or spec[k]
	        tar[k] = function ( ... )
	            method(target, ...)
	        end
	    else
	        tar[k] = v
	    end
	end
    return tar
end

function form.spec(target)
	target.tag = target.tag or form.tag
	if target.super == nil then
	function target:super()-- example. target:super().method(...)
		local name = 'super_'
		local super = self:spec(name)
		if super == nil then
			super = self._super
			super = super and form.on(self, super)
			self:spec(name, super)
		end
		return super or {}
	end
	end
	if target.interface == nil then
	function target:interface( name )
		local name_ = name..'_'
		local interface = self:spec(name_)
		if interface == nil then
			interface = self:spec(name)
			interface = interface and form.on(self, interface)
			self:spec(name_, interface)
		end
		return interface or {}
	end
	end
	if target.message == nil then
	function target:message( method, option )
		option = option or ''
		local tx = option..', not implemented'
		print(self:tag()..method..' '..tx)
	end
	end
	if target.on == nil then
	function target:on(target)
		local tar = {}
		local spec = self
	    for k,v in pairs(spec) do
	        if type(v) == 'function' then
	            tar[k] = function ( ... )
	                spec[k](target, ...)
	            end
	        else
	            tar[k] = v
	        end
	    end
	    print(self:tag()..'['..spec._tag..'] target binding form produced')
	    -- no such key binding to the target
	    tar.on = nil
	    tar.spec = nil
	    return tar
	end
	end
	if target.spec == nil then
	function target:spec(prop, target)
		if  self._interface == nil then
			self._interface = {}
		end
	    local handler = {}
	    function handler.string(self, prop, target)
	        if target ~= nil then
	            print(self:tag()..'['..prop..'] setter/getter produced')
	            local property = '_'..prop
	            local function prop_(self, target)
	                if target ~= nil then
	                    self[property] = target
	                    return self
	                end
	                return self[property]
	            end
	            prop_(self, target)[prop] = prop_
	        end
	        local spec = self[prop](self)
	        return spec and spec:on(self)
	    end
	    function handler.table(self, prop)
	        local target = prop
	        table.insert(self._interface, target)
	        if type(target._tag)=='string' then
	            print(self:tag()..' interface['..target._tag..'] specified')
	        end
	        return self
	    end
	    handler = handler[type(prop)]
	    return handler and handler(self, prop, target)
	end
	end

	return target
end

function form:tag()
	local tag = self._tag
	if type(tag)=='string'
	then
		return '*'..tag..'*'
	end
	return 'none.TAG'
end

function form._meta()
    local meta = {}
    function meta.__index(target, key)
    	-- avoid target._interface rise to C stack overflow, .etc
    	-- following anonymous table specify the key filters
    	if ({_interface = true, _super = true})[key] then return nil end

        local super = target._super
        local interface = target._interface
        local v = super and super[key]
        if v == nil and type(interface)=='table'
        then
            for i=1, #interface do
                v = interface[i][key]
                if v ~= nil then return v end
            end
        end
        return v
    end
    return meta
end

return form