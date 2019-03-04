------------------------------------------------------------------------------
local ffi = require('ffi')
local target = {}
local ctypes = {}
function target.type( name, ad )
	name = table.concat({name, ad})
	local ctype = ctypes[name]
	if ctype == nil then
		ctype = ffi.typeof(name)
		ctypes[name] = ctype
	end
	assert(ctype ~=nil, 'target.type('..name..') =nil')
	return ctype
end
-- VLA ¡ª A variable-length array
function target.vla_resolve(ctype, c, data)
    if c > 0 then
    	ctype = target.type(ctype, '[?]')
		local ct = ctype(c)
		ffi.copy(ct, data, data:len())
		return ct
	end
end
-- VLS ¡ª A variable-length struct is a struct C type where the last element is a VLA. 
function target.vls_resolve(ctype, data)
	ctype = target.type(ctype)
	local offset  = ffi.sizeof(ctype)
	local body = string.sub(data, offset+1)
	local ct = ctype()
	ffi.copy(ct, data, offset)
--	print('['..ctype..'].size = '.. offset..', data.len ='.. data:len())
	return ct, body
end
-- ct ¡ª A C type specification
function target.ct_resolve(ctype, data)
	ctype = target.type(ctype)
	local ct = ctype()
	ffi.copy(ct, data, data:len())
	return ct
end

function target.ct_generate( ctype, des )
--	local str = '['..ctype..'].size:'
	ctype = target.type(ctype)
	local cdata, size = ctype(des), ffi.sizeof(ctype)
	local res = ffi.string(cdata, size)
--	print(str..size)
	return res
end

function target.vls_generate( htype, ctype, des )
	local list = table.remove(des)
	if type(list) ~= 'table' then return end
	local c = #list
	local headt = target.type(htype)
	local vlat = target.type(ctype, '[?]')
	local head = headt(des)
	local array = vlat(c, list)
	local hz, az = ffi.sizeof(htype), ffi.sizeof(vlat, c)
	local t = {ffi.string(head, hz), ffi.string(array, az)}

--	local size = hz + az
--	local str = '{'..htype..'; '..ctype..'['..c..']}.size:'
--	print(str..size)
	return table.concat(t)
end

--[[
function target.table( cdata, fields )
function target.table( cdata, {field, param, alias } ) -- #param ={table, string, value}]]
function target.table( cdata, params )
	local res = {}
	if cdata == nil then return res end
	for i,param in ipairs(params) do
		local t = type(param)
		if t == 'string' then
			res[param] = cdata[param]
		elseif t == 'table' then
			local field, param_, alias = unpack(param)
			local t = type(param_)
			
			if t =='string'and param_~='string'
			then alias = param_ end
			
			local key = alias or field
			local value = cdata[field]
			if t == 'table' then
				res[key] = target.table(value, param_)
			elseif t == 'number' and value~=nil then
				res[key] = target.table4a(value, param_)
			elseif param_=='string' then
				res[key] = ffi.string(value)
			elseif param_~=nil then
				res[key] = param_
			else
				res[key] = value
			end
		end
	end
	return res
end
target.table4s = target.table -- table for struct
--[[
target.table4a(cdata, count) -- table for array
target.table4a(cdata, count, {fields})]]
function target.table4a( cdata, count, fields )
	local res = {}
	if cdata == nil then return res end
	local t = type(fields)
	for i=1,count do
		local item = cdata[i-1]
		if t=='string' and fields=='string' then
			item = ffi.string(item)
		elseif t == 'table' then
			item = target.table(item, fields)
		end
		res[i] = item
	end
	return res
end

return target
