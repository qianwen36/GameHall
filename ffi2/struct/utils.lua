local ffi = require('ffi')
local ffi2 = import('.ffi2')

local target = {}
local TAG = '************[struct.utils] '
local function log( ... )
	print(table.concat({TAG, ...}))
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
		local head, size = ffi2.ct_resolve(ctype, data)
		local value = data:sub(size+1)
		local array, size2 = ffi2.vla_resolve(itype, head[cfield], value)
		return {head, array}, size+size2
	end
	return ffi2.ct_resolve(ctype, data)
end

function target.generate( Data, ctype, htype )
	if htype == nil then
		return ffi2.ct_generate(ctype, Data)
	end
	return ffi2.vls_generate(htype, ctype, Data)
end

local function array( rest, ... )
	return {...}, rest
end
local arrayType = {
	['char']		= '<c',
	['signed char']	= '<c',
	['unsigned char'] = '<B',
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

-- target.cdef = ffi2.cdef
-- target.sdef = ffi2.sdef
-- local function struct_info( t, def, fields )
-- 	table.insert(t, def..'=')
-- 	table.insert(t, '{')
-- 	for line in fields:gmatch('\n%s*(%a+.-;).-') do
-- 		local type, field, dims = line:match('([_%w]+)%s*([_%w]+)(.-);')
-- 		local fdes = nil -- field description
-- 		if dims:len() >0 then
-- 			local td = {}
-- 			for dim in dims:gmatch('%[(.-)%]') do
-- 				table.insert(td, dim)
-- 			end
-- 			local c = #td
-- 			local tchar = 'char' == type or type == 'TCHAR'
-- 			if c == 1 then
-- 				if tchar then
-- 					fdes = table.concat({'\t{"', field, '", "string"},'})
-- 				else
-- 					local count = tonumber(td[1]) or table.concat({'"', td[1], '"'})
-- 					if type:len() > 5 then
-- 						fdes = table.concat({'\t{"', field, '", ', count, ', "', type, '"},'})
-- 					else
-- 						fdes = table.concat({'\t{"', field, '", ', count, '},'})
-- 					end
-- 				end
-- 			elseif c == 2 then
-- 				local count = tonumber(td[1]) or table.concat({'"', td[1], '"'})
-- 				if tchar then
-- 					fdes = table.concat({'\t{"', field, '", ', count, ', "string"},'})
-- 				else
-- 					local c2 = tonumber(td[2]) or table.concat({'"', td[2], '"'})
-- 					fdes = table.concat({'\t{"', field, '", ', count, ', ', c2, '},'})
-- 				end
-- 			else --c == 0 or too many
-- 				log(line, ' from ', def, ' is not support')
-- 			end
-- 		elseif type:len() > 5 then
-- 			fdes = table.concat({'\t{"', field, '", "', type, '"},'})
-- 		else --[[TCHAR, DWORD, BOOL, BYTE, int]]
-- 			fdes = table.concat({'\t"', field, '",'})
-- 		end
-- 		if fdes then table.insert(t, fdes) end
-- 	end
-- 	table.insert(t, '},')
-- end
-- local function enum_info( t, def, values )
-- 	local e, inc = {}, 0
-- 	local search = {e}
-- 	for name, v in values:gmatch('\n%s*([_%w]+)%s*(=?.-),') do
-- 		if v:len() >0 then
-- 			inc = target.value(v:match('[_%w]+.-'), search)
-- 		end
-- 		e[name] = inc
-- 		inc = inc + 1
-- 	end

-- 	local typedef = def:len() >0
-- 	local tab = (typedef and '\t') or ''
-- 	if typedef then
-- 		table.insert(t, def..'=')
-- 		table.insert(t, '{')
-- 	end
-- 	for k,v in pairs(e) do
-- 		local edes = table.concat({tab, k, '=', v, ','})
-- 		table.insert(t, edes)
-- 	end
-- 	if typedef then
-- 		table.insert(t, '},')
-- 	end
-- end
-- local function value_check( var, search )
-- 	for i,v in ipairs(search) do
-- 		local t = v[var]
-- 		if t~= nil then return t end
-- 	end
-- end
-- local arithmetic = {
-- 	['+'] = function ( a, b ) return a + b end;
-- 	['-'] = function ( a, b ) return a - b end;
-- 	['*'] = function ( a, b ) return a * b end;
-- 	['/'] = function ( a, b ) return a / b end;
-- 	['%'] = function ( a, b ) return a % b end;
-- }
-- function target.value( var, search )
-- 	local ret = tonumber(var)
-- 	if ret == nil then
-- 		ret = value_check(var, search)
-- 		if ret == nil then
-- 			local op = var:match('[%+%-%*%%%/]')
-- 			if op ~= nil then
-- 				local a, b = var:match(table.concat({'([_%w]+)%s-%', op, '%s-([_%w]+)'}))
-- 				a = tonumber(a) or value_check(a, search)
-- 				b = tonumber(b) or value_check(b, search)
-- 				if a ~= nil and b ~= nil then
-- 					ret = arithmetic[op](a, b)
-- 				end
-- 			end
-- 		end
-- 	end
-- 	if ret == nil then log(var, ' can not resolve!') end
-- 	return ret
-- end

-- function target.genDesc( spath, cdecl ) -- spath: struct.lua from path2()
-- 	local t = {'return {'}
-- 	for values, def in cdecl:gmatch('enum.-(%b{})%s*([_%w]-);') do
-- 		enum_info(t, def, values)
-- 	end
-- 	for fields, def in cdecl:gmatch('typedef struct %g-%s*(%b{})%s*([_%w]+)') do
-- 		struct_info(t, def, fields)
-- 	end
-- 	table.insert(t, '}')
-- 	local content = table.concat(t, '\n')
-- 	io.writefile(spath, content)
-- end

-- local function resolve_quote( param, search )
-- 	local quote = type(param) == 'string' and param ~= 'string'
-- 	if quote then
-- 		return quote, value_check(param, search) or target.value(param, search)
-- 	end
-- 	return quote
-- end
-- function target.resolveTypes( desc, ... )
-- 	for def, fields in pairs(desc) do
-- 		local c = (type(fields) == 'table' and #fields) or 0
-- 		if c >0 then
-- 			for i, field in ipairs(fields) do
-- 				if type(field) == 'table' then
-- 					local param, param2, search = field[2], field[3], {desc, ...}
-- 					if param2 then
-- 						field[2] = target.value(param, search)
-- 						local quote, v = resolve_quote(param2, search)
-- 						if quote then field[3] = v end
-- 					else
-- 						local quote, v = resolve_quote(param, search)
-- 						if quote then field[2] = v end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- 	return desc
-- end

local function struct_func( t, def, fields )
	table.insertto(t, {
		table.concat{def,'\t= function(ct)'},
		'return {'
	})
	for line in fields:gmatch('\n%s*(%a+.-;).-') do
		local type, field, dims = line:match('([_%w]+)%s*([_%w]+)(.-);')
		local tab, fdes = '\t' -- field description
		if dims:len() >0 then
			local td = {}
			for dim in dims:gmatch('%[(.-)%]') do
				table.insert(td, dim)
			end
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
		else --[[TCHAR, DWORD, BOOL, BYTE, int]]
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
	for fields, def in cdecl:gmatch('typedef struct %g-%s*(%b{})%s*([_%w]+)') do
		struct_func(t, def, fields)
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

--------------------------------------------------------------------------
local packSize = {
	h = 2, H = 2,
	i = 4, I = 4,
	l = 4, L = 4,
	f = 4, d = 8,
}
local function sub( array, f, e )
	array = {unpack(array)}
	if f > 0 and f <= #array then
		if e and e > f then
			for i=e+1,#array do
				table.remove(array)
			end
		end
		for i=1,f-1 do
			table.remove(array, 1)
		end
	end
	return array
end
local function product(array)
	local ret = 1
	for i=1,#array do
		ret = ret * array[i]
	end
	return ret
end
local function format( desc, c )
	local ret = desc.fmt
	if type(ret) == 'table' then
		local index = c or 1
		ret = ret[index]
	end

	if ret == nil then
		if desc.len then
			local a = {'<'}
			for i=1, #desc do
				local fdes = desc[i]
				local ty, c = fdes[2], fdes[3]
				if type(ty) == 'table' then
					c = c and c*ty.len or ty.len
				elseif c then
					c = c * packSize[ty]
				end
				if c then
					ty = 'A'..c
				end
				table.insert(a, ty)
			end
			desc.fmt = table.concat(a)
			ret = desc.fmt
		else
			local field, ty = unpack(desc)
			local dims, index = sub(desc, 3), c or 1
			local c = #dims
			local rep = c > 1 and product(sub(dims, index+1)) or 1

			c = dims[index]
			if c then
				ret = desc.fmt
				desc.fmt = ret or {}
				if type(ty) == 'table' then
					ret = table.concat{'<', string.rep('A'..(ty.len*rep), c)}
				else
					ret = table.concat{'<', ty, c*rep}
				end
				desc.fmt[index] = ret
			else
				ret = '<'..ty
			end
		end
	end
	return ret
end

function target.pack( t, desc, c )
	local ret
	if c then
		local list = {}
		for i=1,c do
			local value = t[i] or {}
			value = target.pack(value, desc)
			table.insert(list, value)
		end
		ret = table.concat(list)
	else
		local list = {}
		for i=1,#desc do
			local fdes = desc[i]
			local field, ty, c = unpack(fdes)
			local value = t[field]
			if type(ty) == 'table' then
				value = target.pack(value or {}, fdes, c)
			else
				if c then
					local fmt = format(fdes):gsub('A%d*', 'A')
					value = target.fill(value, c, 0)
					value = string.pack(fmt, unpack(value))
				end
			end
			table.insert(list, value or 0)
		end
		local fmt = format(desc):gsub('A%d*', 'A')
		ret = string.pack(fmt, unpack(list))
	end
	return ret
end

function target.unpack( data, desc, c )
	local ret, rest = {}
	if c then
		local fmt = table.concat{'<', string.rep('A'..desc.len, c)}
		local value = array(string.unpack(data, fmt))
		for i=1,c do
			value[i] = target.unpack(value[i], ty)
		end
		ret = value
		rest = desc.len +1
	else
		local fmt, list = format(desc)
		list, rest = array(string.unpack(data, fmt))
		for i=1,#list do
			local fdes, value = desc[i], list[i]
			local field, ty, c = unpack(fdes)
			if type(ty) == 'table' then
				if c then
					local fmt = format(fdes)
					value = array(string.unpack(value, fmt))
					for i=1,c do
						value[i] = target.unpack(value[i], ty)
					end
				else
					value = target.unpack(value, ty)
				end
			else
				if c then
					local fmt = format(fdes)
					value = array(string.unpack(value, fmt))
				end
			end
			ret[field] = value
		end
	end
	return ret, rest
end

function target.fill( t, c, ref )
	local ty = type(t)
	if ty == 'table' then
		ref = ref or 0
		for i=#t+1, c do
			table.insert(t, ref)
		end
	elseif ty == 'string' then
		t = string.sub(t, 1, c)
		c = c - string.len(t)
		if (c >0) then
			t = t..string.rep('\0', c)
		end
	end
	return t
end

return target