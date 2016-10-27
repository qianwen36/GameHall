
local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:onCreate()
	local plugins = self:getConfig('plugins')
	if plugins.get == nil then
		function plugins:get( name )
			local t = self[name]
			local path, param
			if (type(t)=='table') then
				t = {unpack(t)}
				path = table.remove(t, 1)
				param = t
			else
				path = t
			end
			return require(self.root..'.'..path), param
		end
	end
	self.plugins_ = plugins
	self.models_ = {}
	self.presenters_ = {}
	if USING_MCRuntime then
		self:model('BaseHall'):start(self:getConfig('hall').config)
	end
end

function MyApp:getConfig( name )
	return self.configs_[name]
end

function MyApp:plugin( name )
	local plugins = self.plugins_
    if (plugins ~= nil) then
	    return plugins:get(name)
    end
end

function MyApp:wrapParam( param, default )
	param = param or {default}
	if type(param)~= 'table' then param={param} end
	return param
end

function MyApp:presenter( name )
	return self:module('presenter', name)
end

function MyApp:model( name )
	return self:module('model', name)
end

function MyApp:module(mod, name)
	local mods = self[mod..'s_']
	local module_ = mods[name]
	if module_~=nil then return module_ end
	local roots = self.configs_[mod..'sRoot'] or self.configs_.viewsRoot
    for _, root in ipairs(roots) do
        local packageName = string.format("%s.%s", root, name)
        local status, module_ = xpcall(function()
                return require(packageName)
            end, function(msg)
            if not string.find(msg, string.format("'%s' not found:", packageName)) then
                print("load module_ error: ", msg)
            end
        end)
        local t = type(module_)
        if status then
        	if t == "userdata" then
        		mods[name] = module_
	            return module_
        	elseif(t == "table") then
        		mods[name] = module_
        		if type(module_.init)=='function' then
        			module_:init(self)
        		end
        		return module_ 
        	end
        end
    end
    error(string.format("MyApp:module() - not found module \"%s\" in search paths \"%s\"",
        name, table.concat(roots, ",")), 0)
end

return MyApp
