-- require('struct.predefine')
local socket = require('socket')
local ffi = require('ffi')
local utils = import('struct.utils')
local base = utils.dereference(import('struct.BaseGameStruct.struct'))
local mj = utils.dereference(import('struct.MJGameStruct.struct'))
local my = utils.dereference(import('struct.MyGameStruct.struct'), mj, base)
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

function target.test()
	local data = areasData
    local desc = '.struct_desc'
    local cdecl = [[
typedef unsigned int       DWORD;
typedef int                 BOOL;
typedef char                TCHAR, *PTCHAR;
typedef unsigned char       BYTE;
// #define      MAX_CHAIR_COUNT         8           // 每张桌子的最多椅子数,每个游戏最多16人
// #define      MAX_CHAIRS_PER_TABLE    MAX_CHAIR_COUNT     // 每张桌子的最多椅子数
// #define      MAX_CARDS_PER_CHAIR     64          // 每张椅子的最多牌张数    
// #define     MJ_CHAIR_COUNT           4  // 麻将牌人数
// #define     MJ_UNIT_LEN             4           // 牌型最多牌张数
// #define	   MAX_SERIALNO_LEN		32			// 每局序列号最大长度
// #define	   MAX_DICE_NUM			4			// 最多骰子个数
// #define     MJ_MAX_PENG             6   // 最大碰牌数
// #define     MJ_MAX_CHI              6   // 最大吃牌数
// #define     MJ_MAX_PENG             6   // 最大碰牌数
// #define     MJ_MAX_GANG             6   // 最大杠牌数
// #define     MJ_MAX_OUT              36  // 最大打牌数
// #define     MJ_MAX_HUA              36  // 最大补花数
// #define     MJ_GF_14_HANDCARDS          14      // 14张麻将
// #define     MJ_GF_17_HANDCARDS          17      // 17张麻将
enum Const {
    TOTAL_CHAIRS            =4,//多少玩家
    CHAIR_CARDS             =32,//每人手上最多多少张牌
    HU_MAX                  =16,  //胡牌种类数34
    EXCHANGE3CARDS_COUNT    =3,
    MAX_CHAIR_COUNT = 8,
    MJ_UNIT_LEN =4,
    MAX_CHAIRS_PER_TABLE = MAX_CHAIR_COUNT,
    MAX_CARDS_PER_CHAIR     =64,            // 每张椅子的最多牌张数    
    MAX_LEVELNAME_LEN = 16,
    MAX_GAMENAME_LEN =  32,
    MAX_AREANAME_LEN =  32,
};

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
    DWORD dwOptions;
    int nFontColor;
    int nIconID;
    int nGifID;//以上9个为对象固定字段
    int nGameID;
    int nServerID;
    TCHAR szAreaName[MAX_AREANAME_LEN];
    int nReserved[8];
}AREA, *LPAREA;

typedef int TCY_CURRENCY;
typedef int TCY_CURRENCY_CONTAINER;
typedef struct _tagCURRENCY_EXCHANGE{
    int                     nUserID;
    TCY_CURRENCY_CONTAINER  nContainer;                 
    TCY_CURRENCY            nCurrency;              
    int                     nExchangeGameID;
    int                     llOperationIDLow;
    int                     llOperationIDHigh;
    int                     llBalanceLow;
    int                     llBalanceHigh;
    int                     nOperateAmount;         //操作数量
    int                     nCreateTime;
    DWORD                   dwFlags;
    
    int                     nReserved[8];
}CURRENCY_EXCHANGE, *LPCURRENCY_EXCHANGE;
typedef struct _tagCURRENCY_EXCHANGE_EX{
    CURRENCY_EXCHANGE       currencyExchange;
    
    DWORD                   dwNotifyFlags;
    int                     nEnterRoomID;           //通知时带上的玩家所在房间roomid，和本次变化无关
    
    int                     nReserved[16];
}CURRENCY_EXCHANGE_EX, *LPCURRENCY_EXCHANGE_EX;

typedef struct _tagCARDS_THROW
{
    int nUserID;                                // 用户ID
    int nChairNO;                               // 位置
    int nNextChair;                             // 下一个
    BOOL bNextFirst;                            // 下一个是否第一手出牌
    BOOL bNextPass;                             // 下一个是否自动放弃
    int nRemains;                               // 剩下几张
    DWORD dwFlags[MAX_CHAIR_COUNT];             // 标志
    DWORD dwCardsType;                          // 牌型
    int nThrowCount;                            // 出牌第几手计数
    int nReserved[4];
    int nCardsCount;                            // 牌张数
    int nCardIDs[MAX_CARDS_PER_CHAIR];          // 打出的牌(ID)
} CARDS_THROW, *LPCARDS_THROW;
typedef struct _tagEXCHANGE3CARDS
{
    int nUserID;                                    // 用户ID
    int nRoomID;                                    // 房间ID
    int nTableNO;                                   // 桌号
    int nChairNO;                                   // 位置
    int nSendTable;                                 //
    int nSendChair;
    int nSendUser;
    int nExchange3CardsCount;
    int nExchangeDirection;
    int nExchange3Cards[TOTAL_CHAIRS][EXCHANGE3CARDS_COUNT];//jiaohuan的牌
    int nReserved[4];
} EXCHANGE3CARDS, *LPEXCHANGE3CARDS;
        ]]
    utils.genDesc(utils.path2(desc), cdecl)
    local ok, msg = pcall(ffi.cdef, cdecl)
    -- local StructDef = import('.struct_desc')
    local MCSocketDataStruct = RequestConfig.MCSocketDataStruct
    local info = _DataMap(mc.UR_OPERATE_SUCCEED, mc.GET_AREAS, data)
    local StructDef2 = {
        {'nUserID', 'i'},      -- [1] ( int )
        {'nChairNO', 'i'},     -- [2] ( int )
        {'nNextChair', 'i'},       -- [3] ( int )
        {'bNextFirst', 'i'},       -- [4] ( int )
        {'bNextPass', 'i'},        -- [5] ( int )
        {'nRemains', 'i'},     -- [6] ( int )
        {'dwFlags', 'L', 8},      -- [7] ( unsigned long )
        {'dwCardsType', 'L'},      -- [8] ( unsigned long )
        {'nThrowCount', 'i'},      -- [9] ( int )
        {'nReserved', 'i', 4},        -- [10] ( int )
        {'nCardsCount', 'i'},      -- [11] ( int )
        {'nCardIDs', 'i', 64},     -- [12] ( int )
        len = 340
    }
    MCSocketDataStruct.CARDS_THROW ={
        lengthMap = {
            -- [1] = nUserID( int ) : maxsize = 4,
            -- [2] = nChairNO( int )    : maxsize = 4,
            -- [3] = nNextChair( int )  : maxsize = 4,
            -- [4] = bNextFirst( int )  : maxsize = 4,
            -- [5] = bNextPass( int )   : maxsize = 4,
            -- [6] = nRemains( int )    : maxsize = 4,
                                                    -- dwFlags  : maxsize = 32  =   4 * 8 * 1,
            [7] = { maxlen = 8 },
            -- [8] = dwCardsType( unsigned long )   : maxsize = 4,
            -- [9] = nThrowCount( int ) : maxsize = 4,
                                                    -- nReserved    : maxsize = 16  =   4 * 4 * 1,
            [10] = { maxlen = 4 },
            -- [11] = nCardsCount( int )    : maxsize = 4,
                                                    -- nCardIDs : maxsize = 256 =   4 * 64 * 1,
            [12] = { maxlen = 64 },
            maxlen = 12
        },
        nameMap = {
            'nUserID',      -- [1] ( int )
            'nChairNO',     -- [2] ( int )
            'nNextChair',       -- [3] ( int )
            'bNextFirst',       -- [4] ( int )
            'bNextPass',        -- [5] ( int )
            'nRemains',     -- [6] ( int )
            'dwFlags',      -- [7] ( unsigned long )
            'dwCardsType',      -- [8] ( unsigned long )
            'nThrowCount',      -- [9] ( int )
            'nReserved',        -- [10] ( int )
            'nCardsCount',      -- [11] ( int )
            'nCardIDs',     -- [12] ( int )
        },
        formatKey = '<i6L9i70',
        deformatKey = '<i6L9i70',
        maxsize = 340
    }
    MCSocketDataStruct.EXCHANGE3CARDS={
        lengthMap = {
            -- [1] = nUserID( int ) : maxsize = 4,
            -- [2] = nRoomID( int ) : maxsize = 4,
            -- [3] = nTableNO( int )    : maxsize = 4,
            -- [4] = nChairNO( int )    : maxsize = 4,
            -- [5] = nSendTable( int )  : maxsize = 4,
            -- [6] = nSendChair( int )  : maxsize = 4,
            -- [7] = nSendUser( int )   : maxsize = 4,
            -- [8] = nExchange3CardsCount( int )    : maxsize = 4,
            -- [9] = nExchangeDirection( int )  : maxsize = 4,
                                                    -- nExchange3Cards  : maxsize = 48  =   4 * 3 * 4,
            [10] = { maxlen = 3, maxwidth = 4, complexType = 'matrix2' },
                                                    -- nReserved    : maxsize = 16  =   4 * 4 * 1,
            [11] = { maxlen = 4 },
            maxlen = 11
        },
        nameMap = {
            'nUserID',      -- [1] ( int )
            'nRoomID',      -- [2] ( int )
            'nTableNO',     -- [3] ( int )
            'nChairNO',     -- [4] ( int )
            'nSendTable',       -- [5] ( int )
            'nSendChair',       -- [6] ( int )
            'nSendUser',        -- [7] ( int )
            'nExchange3CardsCount',     -- [8] ( int )
            'nExchangeDirection',       -- [9] ( int )
            'nExchange3Cards',      -- [10] ( int )
            'nReserved',        -- [11] ( int )
        },
        formatKey = '<i25',
        deformatKey = '<i25',
        maxsize = 100
    }
    -- StructDef2 = {
    -- {'nAreaID', 'i'},
    -- {'nAreaType', 'i'},
    -- {'nSubType', 'i'},
    -- {'nStatus', 'i'},
    -- {'nLayOrder', 'i'},
    -- {'dwOptions', 'L'},
    -- {'nFontColor', 'i'},
    -- {'nIconID', 'i'},
    -- {'nGifID', 'i'},
    -- {'nGameID', 'i'},
    -- {'nServerID', 'i'},
    -- {'szAreaName', 'c', 32},
    -- {'nReserved', 'i', 8},
    -- len = 108,
    -- }
    info = ffi.new('CURRENCY_EXCHANGE_EX', {
        nUserID = 77681,
        nChairNO = 1,
        nNextChair = 2,
        nCardIDs = {2,3,5,6,8,0},
        nExchange3Cards = {
            {1,2,3}, {2,5,6}, {1,2,3}, {7,8,9}
        },
        currencyExchange = {
            nUserID = 77681,
            nContainer = 1,
            nCurrency = 2,
            nExchangeGameID = 381,
        }, dwNotifyFlags = 80, nEnterRoomID = 445,
        })
    data = ffi.string(info, ffi.sizeof('CURRENCY_EXCHANGE_EX'))
    info = utils.unpack(data, base.CURRENCY_EXCHANGE_EX)
    if  data == utils.pack(info, base.CURRENCY_EXCHANGE_EX) then
        print('Success**************')
    else
        print('Failed***************')
    end
	print('test-------------------------------------------')
    local t, t2 = socket.gettime(), 0
    -- for i=1,1000 do
    --     TreePack.unpack(data, MCSocketDataStruct.EXCHANGE3CARDS)
    --     -- TreePack.alignpack(info, MCSocketDataStruct.CARDS_THROW)
    -- end
    -- local areasInfo = _DataMap(mc.UR_OPERATE_SUCCEED, mc.GET_AREAS, data)
    -- for i=1,1000
    -- do
    --     local t = {}
    --     for i,info in ipairs(info[2]) do
    --         t[i] = TreePack.alignpack(info, MCSocketDataStruct.AREA)
    --     end
    --     table.insert(t, 1, TreePack.alignpack(info[1],  MCSocketDataStruct.AREAS))
    --     local s = table.concat( t )
    --     if s ~= data then print('TreePack.alignpack error') end
    --     -- areasInfo = _DataMap(mc.UR_OPERATE_SUCCEED, mc.GET_AREAS, data)
    -- end
    t2 = socket.gettime()
    print('use treepack ...'..(t2-t))
	-- dump(areasInfo, "from treepack")
    t = socket.gettime()
    -- for i=1,1000 do
    --     utils.unpack(data, my.EXCHANGE3CARDS)
    --     -- utils.pack(info, my.EXCHANGE3CARDS)
    --     -- StructDef.CARDS_THROW(utils.resolve('CARDS_THROW', data))
    -- end
    -- local a, size = utils.resolve('AREAS', {'nCount', 'AREA', data})
    -- local head, array = unpack(a)
    -- local areasInfo2 = { StructDef.AREAS(head), utils.table4a(array, head.nCount, StructDef.AREA) }

    -- for i=1,1000
    -- do
    --     local t = clone(info[1])
    --     table.insert(t, info[2])
    --     local s = utils.generate(t, 'AREA', 'AREAS')
    --     if s ~= data then print('utils.generate error') end
    --     -- info, size = utils.resolve('AREAS', {'nCount', 'AREA', data})
    --     -- head, array = unpack(info)
    --     -- areasInfo2 = {
    --     --     utils.table4s(head, StructDef.AREAS),
    --     --     utils.table4a(array,  head.nCount, StructDef.AREA)
    --     -- }
    -- end
    t2 = socket.gettime()
    print('use ffi struct ...'..(t2-t))
    -- dump(areasInfo2, 'from struct')
    print('test-------------------------------------------')
end

return target