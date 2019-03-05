require('struct.predefine')
local socket = require('socket')
local ffi = require('ffi')
local utils = import('struct.utils')
local TreePack = cc.load('treepack')
local RequestConfig = import('src.app.GameHall.models.mcsocket.MCSocketDataStruct')
local RespondConfig = import('src.app.GameHall.models.mcsocket.MCSocketRespondConfig')
local function _DataMap(respID, reqID, data)
    local dataMap = {}
    local exchMap = RespondConfig.getExchMap(respID, reqID)
    if exchMap ~= nil then
        if (type(exchMap) == 'function') then
            dataMap = exchMap(data)
        else
            if not data then
                dump(exchMap)
            else
                dataMap = TreePack.unpack(data, exchMap)
            end
        end
    end
    return dataMap
end

local target = {}

function target:test()
	local data = areasData
	print('test-------------------------------------------')
    local t, t2 = socket.gettime(), 0
    local areasInfo = _DataMap(mc.UR_OPERATE_SUCCEED, mc.GET_AREAS, data)
    local MCSocketDataStruct = RequestConfig.MCSocketDataStruct
    -- for i=1,1000 do
    --     local t = {}
    --     for i,info in ipairs(areasInfo[2]) do
    --         t[i] = TreePack.alignpack(info, MCSocketDataStruct.AREA)
    --     end
    --     table.insert(t, 1, TreePack.alignpack(areasInfo[1],  MCSocketDataStruct.AREAS))
    --     local s = table.concat( t )
    --     if s ~= data then print('TreePack.alignpack error') end
    --     -- areasInfo = _DataMap(mc.UR_OPERATE_SUCCEED, mc.GET_AREAS, data)
    --     -- local c, array = areasInfo[1].nCount, areasInfo[2]
    --     -- for i=1,c do
    --     --     local item = array[i]
    --     --     local info = {
    --     --         nAreaID = item.nAreaID,
    --     --         nAreaType = item.nAreaType,
    --     --         nSubType = item.nSubType,
    --     --         nStatus = item.nStatus,
    --     --         nLayOrder = item.nLayOrder,
    --     --         dwOptions = item.dwOptions,
    --     --         nFontColor = item.nFontColor,
    --     --         nIconID = item.nIconID,
    --     --         nGifID = item.nGifID,
    --     --         nGameID= item.nGameID,
    --     --         nServerID = item.nServerID,
    --     --         szAreaName = item.szAreaName
    --     --     }
    --     -- end
    -- end
    t2 = socket.gettime()
    print('use treepack ...'..(t2-t))
	-- dump(areasInfo, "from treepack")
    t = socket.gettime()
    -- local StructDef = require('struct.HallDataDef')
    local StructDef = utils.cdes({}, [[
typedef struct _tagAREAS{
    int nCount;
    int nLinkCount;
    int nReserved[2];
}AREAS, *LPAREAS;

typedef struct _tagAREA{
    int nAreaID;
    int nAreaType;
    int nSubType;
    int nStatus;
    int nLayOrder;
    T_DWORD dwOptions;
    int nFontColor;
    int nIconID;
    int nGifID;//以上9个为对象固定字段
    int nGameID;
    int nServerID;
    T_TCHAR szAreaName[MAX_AREANAME_LEN];
    int nReserved[8];
}AREA, *LPAREA;
        ]])
    -- local fields = {
    --                     'nAreaID',
    --                     'nAreaType',
    --                     'nSubType',
    --                     'nStatus',
    --                     'nLayOrder',
    --                     'dwOptions',
    --                     'nFontColor',
    --                     'nIconID',
    --                     'nGifID',
    --                     'nGameID',
    --                     'nServerID',
    --                     {'szAreaName', 'string'},
    --                     {'nReserved', 8}
    --                 }
    local head, array = unpack(utils.resolve('AREAS', {'nCount', 'AREA', data}))
    local areasInfo2 = {
        utils.table4s(head, StructDef.AREAS),
        utils.table4a(array,  head.nCount, StructDef.AREA)
        -- utils.table4s(head, {'nCount', 'nLinkCount'}),
        -- utils.table4a(array,  head.nCount, fields)
    }
    -- for i=1,1000 do
    --     local t = clone(areasInfo2[1])
    --     table.insert(t, areasInfo2[2])
    --     local s = utils.generate(t, 'AREA', 'AREAS')
    --     if s ~= data then print('utils.generate error') end
    --     -- c, array = unpack(utils.resolve('AREAS', {'nCount', 'AREA', data}))
    --     -- for i=1,c do
    --     --     local item = array[i-1]
    --     --     local info = {
    --     --         nAreaID = item.nAreaID,
    --     --         nAreaType = item.nAreaType,
    --     --         nSubType = item.nSubType,
    --     --         nStatus = item.nStatus,
    --     --         nLayOrder = item.nLayOrder,
    --     --         dwOptions = item.dwOptions,
    --     --         nFontColor = item.nFontColor,
    --     --         nIconID = item.nIconID,
    --     --         nGifID = item.nGifID,
    --     --         nGameID= item.nGameID,
    --     --         nServerID = item.nServerID,
    --     --         szAreaName = ffi.string(item.szAreaName)
    --     --     }
    --     -- end
    -- end
    t2 = socket.gettime()
    print('use ffi struct ...'..(t2-t))
    -- dump(areasInfo2, 'from struct')
    print('test-------------------------------------------')
end

return target