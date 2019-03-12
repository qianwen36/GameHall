// #include "BaseGameStruct.h"

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
enum MJGameConst {
    MJ_CHAIR_COUNT          =4,  // 麻将牌人数
    MJ_UNIT_LEN             =4,           // 牌型最多牌张数
    MAX_SERIALNO_LEN        =32,          // 每局序列号最大长度
    MAX_DICE_NUM            =4,           // 最多骰子个数
    MJ_MAX_PENG             =6,   // 最大碰牌数
    MJ_MAX_CHI              =6,   // 最大吃牌数
    MJ_MAX_PENG             =6,   // 最大碰牌数
    MJ_MAX_GANG             =6,   // 最大杠牌数
    MJ_MAX_OUT              =36,  // 最大打牌数
    MJ_MAX_HUA              =36,  // 最大补花数
    MJ_GF_14_HANDCARDS      =14,      // 14张麻将
    MJ_GF_17_HANDCARDS      =17,      // 17张麻将
};

typedef struct _tagCARDS_UNIT
{
    int nCardIDs[MJ_UNIT_LEN];
    int nCardChair;
    int nReserved[2];
} CARDS_UNIT, *LPCARDS_UNIT;

typedef struct _tagGAME_WIN_MJ
{
    GAME_WIN    gamewin;
    int         nNewRound;                      // 下一局是新一轮开始

    int nMnGangs[MJ_CHAIR_COUNT];
    int nAnGangs[MJ_CHAIR_COUNT];
    int nPnGangs[MJ_CHAIR_COUNT];
    int nHuaCount[MJ_CHAIR_COUNT];

    int nResults[MJ_CHAIR_COUNT];   // 胡牌结果
    int nHuChairs[MJ_CHAIR_COUNT];  // 玩家是否胡牌
    int nLoseChair;     // 放冲或者被抢杠者位置
    int nHuChair;       // 胡牌位置
    int nHuCard;        // 胡牌ID
    int nBankerHold;    // 本局是几连庄
    int nNextBanker;    // 下一局谁做庄
    int nChengBaoID;    // 承包者ID
    int nHuCount;       // 胡牌人数

    int nTingChairs[MJ_CHAIR_COUNT];    // 玩家是否听牌
    int nTingCount;                     // 听牌人数
    int nDetailCount;                   // 详细个数

    int nReserved[26];
} GAME_WIN_MJ, *LPGAME_WIN_MJ;

typedef struct _tagMJ_START_DATA
{
    TCHAR   szSerialNO[MAX_SERIALNO_LEN];
    int     nBoutCount;             // 第几局
    int     nBaseDeposit;           // 基本银子
    int     nBaseScore;             // 基本积分
    int     nBanker;                // 庄家椅子号
    int     nBankerHold;            // 连续坐庄局数
    int     nCurrentChair;          // 当前活动椅子号
    DWORD   dwStatus;               // 当前状态
    DWORD   dwCurrentFlags;         // 当前能否天胡

    int     nFirstCatch;            // 先摸牌的人的座位
    int     nFirstThrow;            // 先出牌的人的座位

    int     nThrowWait;             // 出牌等待时间(秒)
    int     nMaxAutoThrow;          // 由系统指定的最大自动出牌数,达到这个数目就断线
    int     nEntrustWait;           // 托管等待时间(秒)

    BOOL    bNeedDeposit;           // 是否需要银子
    BOOL    bForbidDesert;          // 禁止强退

    int     nDices[MAX_DICE_NUM];   // 骰子大小
    BOOL    bQuickCatch;            // 快速抓牌
    BOOL    bAllowChi;              // 允许吃
    BOOL    bAnGangShow;            // 暗杠的牌能否显示
    BOOL    bJokerSortIn;           // 财神牌不固定放头上
    BOOL    bBaibanNoSort;          // 替代财神牌不排序放
    int     nBeginNO;               // 开始摸牌位置
    int     nJokerNO;               // 财神位置
    int     nJokerID;               // 财神牌ID
    int     nJokerID2;              // 财神牌ID2
    int     nFanID;                 // 翻牌ID
    int     nTailTaken;             // 尾上被抓牌张数
    int     nCurrentCatch;          // 当前抓牌位置
    int     nPGCHWait;              // 碰杠吃胡等待时间(秒)
    int     nPGCHWaitEx;            // 碰杠吃胡等待时间(追加)(秒)

    int     nReserved[8];
} MJ_START_DATA, *LPMJ_START_DATA;


typedef struct _tagMJ_PLAY_DATA
{
    CARDS_UNIT  PengCards[MJ_CHAIR_COUNT][MJ_MAX_PENG]; // 碰出的牌
    int         nPengCount[MJ_CHAIR_COUNT];
    CARDS_UNIT  ChiCards[MJ_CHAIR_COUNT][MJ_MAX_CHI];   // 吃出的牌
    int         nChiCount[MJ_CHAIR_COUNT];
    CARDS_UNIT  MnGangCards[MJ_CHAIR_COUNT][MJ_MAX_GANG];   // 明杠出的牌
    int         nMnGangCount[MJ_CHAIR_COUNT];
    CARDS_UNIT  AnGangCards[MJ_CHAIR_COUNT][MJ_MAX_GANG];   // 暗杠出的牌
    int         nAnGangCount[MJ_CHAIR_COUNT];
    CARDS_UNIT  PnGangCards[MJ_CHAIR_COUNT][MJ_MAX_GANG];   // 碰杠出的牌
    int         nPnGangCount[MJ_CHAIR_COUNT];
    int         nOutCards[MJ_CHAIR_COUNT][MJ_MAX_OUT];  // 打出的牌
    int         nOutCount[MJ_CHAIR_COUNT];
    int         nHuaCards[MJ_CHAIR_COUNT][MJ_MAX_HUA];  // 补花打出的牌
    int         nHuaCount[MJ_CHAIR_COUNT];

    int     nReserved[8];
} MJ_PLAY_DATA, *LPMJ_PLAY_DATA;

// C++ 名字SYSTEMMSG
typedef struct _tagSYSMSG
{
    int  nRoomID;                                   // 房间ID
    int  nUserID;                                   // 用户ID
    int  nMsgID;                                    // 消息号
    int  nChairNO;                                  // 位置
    int  nFangCardChairNO;                          // 放冲位置
    DWORD nEventID;                                 // 事件号
    DWORD nMJID;                                    // 牌号
} SYSMSG, *LPSYSMSG;

typedef struct _tagCARD_CAUGHT
{
    int nChairNO;               // 位置
    int nCardID;                // 牌ID
    int nCardNO;                // 牌位置
    DWORD dwFlags;              // 标志
    int nReserved[4];
} CARD_CAUGHT, *LPCARD_CAUGHT;

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

typedef struct _tagCOMB_CARD
{
    int nUserID;                // 用户ID
    int nRoomID;                // 房间ID
    int nTableNO;               // 桌号
    int nChairNO;               // 位置
    int nCardChair;             // 吃碰杠牌所属位置
    int nCardID;                // 吃碰杠牌ID
    int nBaseIDs[MJ_UNIT_LEN - 1];// 手里或碰出的牌
    DWORD dwFlags;              // 标志位
    int nCardGot;               // 杠到的牌
    int nCardNO;                // 杠到的牌位置
    int nReserved[4];
} COMB_CARD, *LPCOMB_CARD;

typedef struct _tagPREGANG_OK
{
    int nChairNO;               // 位置
    int nCardChair;             // 吃碰杠牌所属位置
    int nCardID;                // 吃碰杠牌ID
    DWORD dwFlags;              // 标志位
    DWORD dwResults[MJ_CHAIR_COUNT];
    int nReserved[4];
} PREGANG_OK, *LPPREGANG_OK;

typedef struct _tagGUO_CARD
{
    int nUserID;                // 用户ID
    int nRoomID;                // 房间ID
    int nTableNO;               // 桌号
    int nChairNO;               // 位置
    int nCardChair;             // 牌所属位置
    int nCardID;                // 牌ID
    int nReserved[4];
} GUO_CARD, *LPGUO_CARD;

typedef struct _tagHUA_CARD
{
    int nUserID;                // 用户ID
    int nRoomID;                // 房间ID
    int nTableNO;               // 桌号
    int nChairNO;               // 位置
    int nCardID;                // 花牌ID
    int nCardGot;               // 杠到的牌
    int nCardNO;                // 杠到的牌位置
    int nReserved[4];
} HUA_CARD, *LPHUA_CARD;

typedef struct _tagHU_CARD
{
    int nUserID;                // 用户ID
    int nRoomID;                // 房间ID
    int nTableNO;               // 桌号
    int nChairNO;               // 位置
    int nCardChair;             // 胡牌所属位置
    int nCardID;                // 胡牌ID
    DWORD dwFlags;              // 标志位
    DWORD dwSubFlags;           // 辅助标志位
    int nReserved[4];
} HU_CARD, *LPHU_CARD;

typedef struct _tagCATCH_CARD
{
    int nUserID;                // 用户ID
    int nRoomID;                // 房间ID
    int nTableNO;               // 桌号
    int nChairNO;               // 位置
    BOOL bPassive;              // 是否被动
    SENDER_INFO sender_info;    // 发送者信息
    int nReserved[4];
} CATCH_CARD, *LPCATCH_CARD;

typedef struct _tagTHROW_CARDS
{
    int nUserID;                                // 用户ID
    int nRoomID;                                // 房间ID
    int nTableNO;                               // 桌号
    int nChairNO;                               // 位置
    BOOL bPassive;                              // 是否被动
    SENDER_INFO sender_info;                    // 发送者信息
    DWORD dwCardsType;                          // 牌型
    int nReserved[4];
    int nCardsCount;                            // 牌张数
    int nCardIDs[MAX_CARDS_PER_CHAIR];          // 打出的牌(ID)
} THROW_CARDS, *LPTHROW_CARDS;

typedef struct _tagTHROW_OK
{
    int nNextChair;                             // 下一个出牌
    BOOL bNextFirst;                            // 是否第一手
} THROW_OK, *LPTHROW_OK;

// lua自定义数据
typedef struct _tagCARD_HUA_EX
{
    CARD_CAUGHT cardCaught;
    int         nHuaCardID;
    int         nReserved[4];
}CARD_HUA_EX, *LPCARD_HUA_EX;

typedef struct _tagCARD_TING_DETAIL
{
    DWORD   dwflags;
    int     nChairNO;
    int     nThrowCardsTing[MJ_GF_14_HANDCARDS];
    BYTE    nThrowCardsTingLays[MJ_GF_14_HANDCARDS][MAX_CARDS_LAYOUT_NUM];  // 出了某张牌之后能听的牌
    BYTE    nThrowCardsTingFan[MJ_GF_14_HANDCARDS][MAX_CARDS_LAYOUT_NUM];  //出了某张牌之后听的番数
    BYTE    nThrowCardsTingRemain[MJ_GF_14_HANDCARDS][MAX_CARDS_LAYOUT_NUM];//听牌剩余的张数
    int     nReserved[4];
} CARD_TING_DETAIL, *LPCARD_TING_DETAIL;

typedef struct _tagCARD_TING_DETAIL_16
{
    DWORD   dwflags;
    int     nChairNO;
    int     nThrowCardsTing[MJ_GF_17_HANDCARDS];
    BYTE    nThrowCardsTingLays[MJ_GF_17_HANDCARDS][MAX_CARDS_LAYOUT_NUM];  // 出了某张牌之后能听的牌
    BYTE    nThrowCardsTingFan[MJ_GF_17_HANDCARDS][MAX_CARDS_LAYOUT_NUM];  //出了某张牌之后听的番数
    BYTE    nThrowCardsTingRemain[MJ_GF_17_HANDCARDS][MAX_CARDS_LAYOUT_NUM];//听牌剩余的张数
    int     nReserved[4];
} CARD_TING_DETAIL_16, *LPCARD_TING_DETAIL_16;

typedef struct _tagMERGE_CARDSTHROW
{
    int nUserID;                                    // 用户ID
    int nChairNO;                                   // 位置
    int nNextChair;                                 // 下一个
    BOOL bNextFirst;                                // 下一个是否第一手出牌
    BOOL bNextPass;                                 // 下一个是否自动放弃
    int nRemains;                                   // 剩下几张
    DWORD dwFlags[MAX_CHAIR_COUNT];                 // 标志
    DWORD dwCardsType;                              // 牌型
    int nThrowCount;                                // 出牌第几手计数
    int nReserved[4];
    int nCardsCount;                                // 牌张数
    CARD_CAUGHT card_caught;                        // 抓牌的牌张信息
    int nCardIDs[MAX_CARDS_PER_CHAIR];              // 打出的牌(ID)
} MERGE_CARDSTHROW, *LPMERGE_CARDSTHROW;

typedef struct _tagMERGE_THROWCARDS
{
    int nUserID;                            // 用户ID
    int nRoomID;                            // 房间ID
    int nTableNO;                           // 桌号
    int nChairNO;                           // 位置
    BOOL bPassive;                          // 是否被动
    SENDER_INFO sender_info;                 // 发送者信息
    DWORD dwCardsType;                      // 牌型
    int nReserved[4];
    int nCardsCount;                        // 牌张数
    CARD_CAUGHT card_caught;                 // 抓牌的牌张信息
    int nCardIDs[MAX_CARDS_PER_CHAIR];      // 打出的牌(ID)
} MERGE_THROWCARDS, *LPMERGE_THROWCARDS;