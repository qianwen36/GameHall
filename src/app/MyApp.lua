
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

function MyApp:model(name)
	local models = self.models_ 
	local model = models[name]
	if model~=nil then return model end

    for _, root in ipairs(self.configs_.modelsRoot) do
        local packageName = string.format("%s.%s", root, name)
        local status, model = xpcall(function()
                return require(packageName)
            end, function(msg)
            if not string.find(msg, string.format("'%s' not found:", packageName)) then
                print("load model error: ", msg)
            end
        end)
        local t = type(model)
        if status then
        	if t == "userdata" then
        		models[name] = model
	            return model
        	elseif(t == "table") then
        		models[name] = model
        		if type(model.init)=='function' then
        			model:init(self)
        		end
        		return model 
        	end
        end
    end
    error(string.format("MyApp:model() - not found model \"%s\" in search paths \"%s\"",
        name, table.concat(self.configs_.modelsRoot, ",")), 0)
end

return MyApp
