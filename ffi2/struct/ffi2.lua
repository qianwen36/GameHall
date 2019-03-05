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
	assert(ctype ~=nil)
	return ctype
end
-- VLA ¡ª A variable-length array
function target.vla_resolve(ctype, c, data)
	assert(c>0)
	ctype = target.type(ctype, '[?]')
	local ct, size = ctype(c), ffi.sizeof(ctype, c)
	ffi.copy(ct, data, size)
	return ct, size
end
-- ct ¡ª A C type specification
function target.ct_resolve(ctype, data)
	ctype = target.type(ctype)
	local ct, size = ctype(), ffi.sizeof(ctype)
	ffi.copy(ct, data, size)
	return ct, size
end

function target.ct_generate( ctype, des )
--	local str = '['..ctype..'].size:'
	ctype = target.type(ctype)
	local cdata, size = ctype(des), ffi.sizeof(ctype)
	local res = ffi.string(cdata, size)
--	print(str..size)
	return res, cdata
end

function target.vls_generate( htype, ctype, des )
	local list = table.remove(des)
	if type(list) ~= 'table' then return end
	local c = #list
	local headt = target.type(htype)
	local vlat = target.type(ctype, '[?]')
	local head = headt(des)
	local array = vlat(c, list)
	local hz, az = ffi.sizeof(head), ffi.sizeof(array)
	local t = {ffi.string(head, hz), ffi.string(array, az)}

--	local size = hz + az
--	local str = '{'..htype..'; '..ctype..'['..c..']}.size:'
--	print(str..size)
	return table.concat(t), {head, array}
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
				local count, fields = param_, alias
				res[key] = target.table4a(value, count, fields)
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
target.table4a(cdata, count, c) -- reference two dimensions
target.table4a(cdata, count, {fields})]]
function target.table4a( cdata, count, fields )
	local res = {}
	if cdata == nil then return res end
	local t = type(fields)
	for i=1,count do
		local item = cdata[i-1]
		if t=='string' and fields=='string' then
			item = ffi.string(item)
		elseif t == 'number' then
			item = target.table4a(item, fields)
		elseif t == 'table' then
			item = target.table(item, fields)
		end
		res[i] = item
	end
	return res
end

local function struct_info( def, fields, target )
	local t = {}
	for line in fields:gmatch('\n%s*(%a+.-;).-') do
		local type, field, dims = line:gmatch('([%w_]+)%s*([%w_]+)(.-);')()
		local reft = target[type] or (target.reference and target.reference(type))
		if dims:len() >0 then
			local td = {}
			for dim in dims:gmatch('%[(.-)%]') do
				local c = tonumber(dim)
				if c == nil then
					local m,n = dim:find('+')
					if m == nil then
						c = ffi.C[dim]
					else
						m,n = dim:sub(0, m-1), dim:sub(n+1)
						c = ffi.C[m]
						c = c + (tonumber(n) or ffi.C[n])
					end
				end
				table.insert(td, c or ffi.C[dim])
			end
			local c = #td
			local tchar = 'char' == type or type == 'TCHAR'
			if c == 1 then
				if tchar then
					table.insert(t, {field, 'string'})
				else
					table.insert(t, {field, td[1], reft})
				end
			elseif c == 2 then
				local des = ((tchar and 'string') or reft) or td[2]

				table.insert(t, {field, td[1], des})
			else --c == 0 or to many
				local tm = {line, ' from ', def, ' is not support'}
				print(table.concat(tm))
			end
		elseif reft~=nil then
			table.insert(t, {field, reft})
		else
			table.insert(t, field)
		end
	end
--	dump(t, def)
	target[def] = t
	return t
end
local struct_pattern = 'typedef struct _tag%g-%s*{%s*(\n.-)%s+}%s*([%w_]+)'
-- resolve c struct definition
function target.cdes( ref, cdecl )
	local ok, msg = pcall(ffi.cdef, cdecl)
	if not ok then print(msg) end

	for fields, def in cdecl:gmatch(struct_pattern) do
		struct_info(def, fields, ref)
	end
	return ref
end

function target.cdef( cdecl, ... )
	local ok, msg = pcall(ffi.cdef, cdecl)
	if not ok then print(msg) end

	local refs = {...}
	local ret = {}
	function ret.reference( type )
		local ret = nil
		for i,map in ipairs(refs) do
			ret = map[type]
			if ret ~=nil then break end
		end
		return ret
	end
	for fields, def in cdecl:gmatch(struct_pattern) do
		struct_info(def, fields, ret)
	end
	ret.reference = nil
	return ret
end

return target
