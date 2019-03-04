import('.HallDataDef')
local ffi2 = import('.ffi2')

local target = {}
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
		local array = ffi2.vla_resolve(itype, head[cfield], value)
		return {head, array}
	end
	return ffi2.ct_resolve(ctype, data)
end

function target.generate( Data, ctype, htype )
	if htype == nil then
		return ffi2.ct_generate(ctype, Data)
	end
	return ffi2.vls_generate(htype, ctype, Data)
end
--[[
target.table4s(cdata, {fields}) -- table for struct of cdata
--]]
target.table4s = ffi2.table4s
--[[
target.table4a(cdata, count) -- table for array
target.table4a(cdata, count, {fields})
--]]
target.table4a = ffi2.table4a

return target