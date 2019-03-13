------------------------------------------------------------------------------
local ffi = require('ffi')
local TAG = '************[struct.ffi2] '
local function log( ... )
	print(table.concat({TAG, ...}))
end
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
-- VLA — A variable-length array
function target.vla_resolve(ctype, c, data)
	assert(c>0)
	ctype = target.type(ctype, '[?]')
	local ct, size = ctype(c), ffi.sizeof(ctype, c)
	ffi.copy(ct, data, size)
	return ct, size
end
-- ct — A C type specification
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
--	log(str..size)
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
--	log(str..size)
	return table.concat(t), {head, array}
end

--[[
function target.table( cdata, fields )
function target.table( cdata, {field, param, alias } ) -- #param ={table, string, value}]]
function target.table( cdata, params )
	local ok = next(params) -- check enum
	if type(ok) == 'string' then return tonumber(cdata) end

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
			
			local key = field
			local value = cdata[field]
			if type(alias) == 'string' then key = alias end
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

--[[
function target.resolve( ctype, {cfield, ctype, data} ) -- overload #1:string, #2:table
function target.resolve( ctype, data )	-- overload #1:string, #2:cdata ]]
function target.resolve( arg, arg2 )
	local ctype, data = arg, arg2
	local cfield, itype
	if type(data) == 'table' then
		cfield, itype, data = unpack(data)
	end
	if type(itype) == 'string'
	and type(cfield)== 'string' then
		local head, size = target.ct_resolve(ctype, data)
		local value = data:sub(size+1)
		local array, size2 = target.vla_resolve(itype, head[cfield], value)
		return {head, array}, size+size2
	end
	return target.ct_resolve(ctype, data)
end

function target.generate( Data, ctype, htype )
	if htype == nil then
		return target.ct_generate(ctype, Data)
	end
	return target.vls_generate(htype, ctype, Data)
end

local function struct_info( def, fields, target )
	local t = {}
	for line in fields:gmatch('\n%s*(%a+.-);') do
		local dims = {}
		line = line:gsub('(%b[])', function(s)
			table.insert(dims, s:match('%[(.-)%]'))
			return ''
		end)
		local field = line:match('%s*([_%w]+)$')
		local ty = line:sub(1, -field:len()-1):gsub('[ \t]+$', '')

		local reft = target[ty] or (target.reference and target.reference(ty))
		if #dims >0 then
			local td = {}
			for i = 1, #dims do
				local dim = dims[i]
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
			else --c == 0 or too many
				log(line, ' from ', def, ' is not support')
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
local struct_pattern = 'typedef struct %g-%s*(%b{})%s*([_%w]+)'
-- resolve c struct definition
function target.sdef( ref, cdecl )
	local ok, msg = pcall(ffi.cdef, cdecl)
	if not ok then log(msg) end

	for fields, def in cdecl:gmatch(struct_pattern) do
		struct_info(def, fields, ref)
	end
	return ref
end

function target.cdef( cdecl, ... )
	local ok, msg = pcall(ffi.cdef, cdecl)
	if not ok then log(msg) end

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

--[[
local function array( rest, ... )
	return {...}, rest
end

local arrayType = {
	['char']		= '<c',
	['signed char']	= '<c',
	['unsigned char'] = '<l',
	['short']		= '<h',
	['signed short']= '<h',
	['unsigned short'] = '<H',
	['long']		= '<l',
	['signed long']	= '<l',
	['unsigned long'] = '<L',
	['int']			= '<i',
	['signed int']	= '<i',
	['unsigned int']= '<I',
	['float']	= '<f',
	['double']	= '<d',
}
function target.table4a( ct, count, construct )
    local a
    if construct then
    	a = {}
	    for i=1,count do
	        local item = ct[i-1]
	        a[i] = (construct and construct(item)) or item
	    end
    else -- construct == nil
    	local desc = tostring(ct)
    	local ty = desc:match('<(.-)%s%(&%)')
    	ty = ty and arrayType[ty]
    	if ty then
    		local data = ffi.string(ct, ffi.sizeof(ct))
    		a = array(
    			string.unpack(data,
    				table.concat{ty, count}))
    	end
		if a == nil then
			log(desc, ' resolve failed!')
			a = {}
		end
    end
    return a
end

local function struct_func( t, def, fields )
	table.insertto(t, {
		table.concat{def,'\t= function(ct)'},
		'return {'
	})
	for line in fields:gmatch('\n%s*(%a+.-;)') do
		local dims = {}
		line = line:gsub('(%b[])', function(s)
			table.insert(dims, s:match('%[(.-)%]'))
			return ''
		end)
		local field = line:match('%s*([_%w]+)$')
		local type = line:sub(1, -field:len()-1):gsub('[ \t]+$', '')
		local tab, fdes = '\t' -- field description
		if #dims >0 then
			local td = dims
			local c = #td
			local tchar = 'char' == type or type == 'TCHAR'
			if c == 1 then
				if tchar then
					fdes = table.concat{tab, field, ' = ffi.string(ct.', field, '),'}
				else
					local params = {'ct.'..field, td[1]}
					if type:len() > 5 then table.insert( params, type ) end
					if type:len() > 5 then
						fdes = table.concat{tab, field, ' = target.table4a(', table.concat(params, ', '), '),'}
					else
						fdes = table.concat{tab, field, ' = table4a(', table.concat(params, ', '), '),'}
					end
				end
			elseif c == 2 then
				if tchar then
					fdes = table.concat{tab, field, ' = target.table4a(ct.', field, ', ', td[1], ', "string"),'}
				else
					local params = {'ct.'..field, td[1], td[2]}
					if type:len() > 5 then table.insert( params, type ) end
					fdes = table.concat{tab, field, ' = target.table4a(', table.concat(params, ', '), '),'}
				end
			else --c == 0 or too many
				log(line, ' from ', def, ' is not support')
			end
		elseif type:len() > 5 then
			fdes = table.concat{tab, field, ' = target.table4s(ct.', field, ', "', type, '"),'}
		else -- TCHAR, DWORD, BOOL, BYTE, int
			fdes = table.concat{tab, field, ' = ', 'ct.', field, ','}
		end
		table.insert(t, fdes)
	end
	table.insertto(t, {
		'}',
		'end,'
	})
end
function target.genDesc( spath, cdecl ) -- spath: struct.lua from path2()
	local t = {
		'local ffi = require("ffi")',
		'local utils = cc.load("struct").utils',
		'local table4a = utils.table4a',
		'-------------------------------------',
		'-- MACRO ',
	}
	for name, value in cdecl:gmatch('#define%s*([_%w]+)%s*([_%w]+)') do
		table.insert( t, table.concat{'local ', name, '\t= ', value} )
	end
	table.insertto(t, {
		'-------------------------------------',
		'-- struct constructor map',
		'local target',
		'target = {',
	})
	for block, def in cdecl:gmatch('typedef struct %g-%s*(%b{})%s*([_%w]+)') do
		struct_func(t, def, block)
	end
	table.insertto(t, {
		'}',
		'return target'
	})
	local content = table.concat(t, '\n')
	-- log(content)
	io.writefile(spath, content)
end

function target.path2(desc)
	local source = debug.getinfo(2).source
	local path = cc.FileUtils:getInstance():fullPathForFilename(source)
	local mod = desc:sub(desc:match('^.*%.'):len()+1)
	path = path:match('^.*/')
	return table.concat({path, mod, '.lua'})
end
]]
return target
