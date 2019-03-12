// #include "MJGameStruct.h"

// #define     TOTAL_CHAIRS            4//多少玩家
// #define     CHAIR_CARDS             32//每人手上最多多少张牌
// #define     HU_MAX                  16  //胡牌种类数34
// #define     EXCHANGE3CARDS_COUNT    3
enum MyGameConst {
    TOTAL_CHAIRS            =4,//多少玩家
    CHAIR_CARDS             =32,//每人手上最多多少张牌
    HU_MAX                  =16,  //胡牌种类数34
    EXCHANGE3CARDS_COUNT    =3,
};

typedef struct _tagGAME_WIN_RESULT
{
    GAME_WIN_MJ gamewin;

    int     nCardsCount[TOTAL_CHAIRS];              // 每个玩家手里的牌的张数
    int     nChairCards[TOTAL_CHAIRS][CHAIR_CARDS]; // 自己手里的牌
    int     nFees[TOTAL_CHAIRS];
    int     nTotalDepositDiff[TOTAL_CHAIRS];        //一局内总输赢
    CARDS_UNIT  nOutCards[TOTAL_CHAIRS][4];     // 玩家碰杠吃出的牌(每个玩家最多4敦)
    int     nOutCount[TOTAL_CHAIRS];
    int     nReserved[8];
} GAME_WIN_RESULT, *LPGAME_WIN_RESULT;


typedef struct _tagCARD_CAUGHT_EX
{
    int nChairNO;                                   // 位置
    int nCardID;                                    // 牌ID
    int nCardNO;                                    // 牌位置
    DWORD dwFlags;                                  // 标志
    int nGangPoint[TOTAL_CHAIRS];
    int nReserved[4];
} CARD_CAUGHT_EX, *LPCARD_CAUGHT_EX;


// lua内的名字是RESULT_ITEM_HEAD
// C++ 的名字是HU_ITEM_HEAD
typedef struct _tagRESULT_ITEM_HEAD
{
    int nCount;
    int nChairNO;
    int nPreSaveAllDeposit;
    int nReserved[4];
} RESULT_ITEM_HEAD, *LPRESULT_ITEM_HEAD;

typedef struct _tagHU_ITEM_INFO
{
    BOOL bWin;                                      //是否输赢
    BOOL bSend;                                     //是否已经发送
    int nHuFlag;                                    //MJ_HU_FANG,MJ_HU_ZIMO,MJ_HU_QGNG等
    int nHuID;                                      //胡牌ID
    int nHuFan;                                     //胡牌番数(这里传的倍数)
    int nHuDeposits;                                //胡牌输赢
    int nHuGains[HU_MAX];                           //胡牌番数
    int nRelateChair[TOTAL_CHAIRS];                 //关系玩家，放炮者或者被抢杠者或者被自摸的人
    int nReserved[4];
} HU_ITEM_INFO, *LPHU_ITEM_INFO;

typedef struct _tagGameEndCheckInfo
{
    int nHuaZhuPoint[TOTAL_CHAIRS];
    int nHuaZhuDePosit[TOTAL_CHAIRS];
    int nDajiaoPoint[TOTAL_CHAIRS];
    int nDajiaoDePosit[TOTAL_CHAIRS];
    int nDrawBackPoint[TOTAL_CHAIRS];
    int nDrawBackDeposit[TOTAL_CHAIRS];
    int nTransferPoint[TOTAL_CHAIRS];
    int nTransferDeposit[TOTAL_CHAIRS];
    int nHuPoint[TOTAL_CHAIRS];
    int nHuDeposit[TOTAL_CHAIRS];
    int nFlag;
    int nReserved[4];
} GAMEEND_CHECK_INFO, *LPGAMEEND_CHECK_INFO;

typedef struct _tagGAME_START_INFO
{
    MJ_START_DATA StartData;

    int     nCardsCount[TOTAL_CHAIRS];              // 每个玩家手里的牌的张数
    int     nChairCards[CHAIR_CARDS];               // 自己手里的牌
    int     nDingQueWait;                           //定缺等待时间
    int     nGiveupWait;                            //放弃等待时间
    int     nShowTask;                              //客户端是否显示任务
    int     nReserved[4];

} GAME_START_INFO, *LPGAME_START_INFO;


typedef struct _tagGAME_TABLE_INFO
{
    MJ_START_DATA StartData;
    MJ_PLAY_DATA PlayData;

    DWORD   dwGameFlags;        //游戏状态
    int     nCardsCount[TOTAL_CHAIRS];              // 每个玩家手里的牌的张数
    int     nChairCards[CHAIR_CARDS];               // 自己手里的牌
    int     nAskExit[TOTAL_CHAIRS];                 //请求退出的次数
    int     nGangKaiCount;                          // 杠个数
    int     nResultDiff[MAX_CHAIR_COUNT][MAX_RESULT_COUNT];
    int     nTotalResult[MAX_CHAIR_COUNT];
    int     nHuReady[TOTAL_CHAIRS];                 //胡牌情况
    int     nHuMJID[TOTAL_CHAIRS];                  //所胡牌
    int     nDingQueCardType[TOTAL_CHAIRS];         //定缺的牌
    int     nDingQueWait;                           //定缺等待时间
    int     nGiveupWait;                            //放弃等待时间
    int     nExchange3CardsWait;                    //换三张等待时间
    int     nExchange3Cards[EXCHANGE3CARDS_COUNT];  //换三张的牌
    int     nShowTask;                              //客户端是否显示任务
    int     nLastThrowNO;                           //最近一次出牌玩家
    DWORD   dwPGCHFlags[TOTAL_CHAIRS];
    DWORD   dwPregGangFlags;                        // 抢杠胡切后台回来用
    int     nPreGangCardID;
    int     nReserved[4];
} GAME_TABLE_INFO, *LPGAME_TABLE_INFO;

//lua端自定义
typedef struct _tagGAME_PLAY_INFO
{
    MJ_PLAY_DATA    PlayData;
    int             nReserved[4];
}GAME_PLAY_INFO, *LPGAME_PLAY_INFO;

typedef struct _tagHU_DETAILS_EX
{
    int     nChairNO;
    DWORD   dwHuFlags[2];       // 胡牌标志
    int     nHuGains[HU_MAX];   // 胡牌番数
    int     nTotalGains;        // 总番数
    int     nGangGains;         // 杠牌奖励
    int     nHasGang;           // 是否杠过牌
    int     nFourBao;           // 4宝讨赏
    int     nFeiBao;            // 飞宝个数
    int     nBankerHold;        //连庄局数
    int     nReserved[4];
} HU_DETAILS_EX, *LPHU_DETAILS_EX;

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

typedef struct _tagSYSTEMMSG
{
    int  nRoomID;                                   // 房间ID
    int  nUserID;                                   // 用户ID
    int  nMsgID;                                    // 消息号
    int  nChairNO;                                  // 位置
    int  nFangCardChairNO;                          // 放冲位置
    DWORD nEventID;                                 // 事件号
    DWORD nMJID;                                    // 牌号
} SYSTEMMSG, *LPSYSTEMMSG;

typedef struct _tagAUCTION_DINGQUE
{
    int nDingQueCardType[TOTAL_CHAIRS];             //定缺的牌 nCards
    BOOL bAuto;                                     //
    int nUserID;                                    // 用户ID
    int nRoomID;                                    // 房间ID
    int nTableNO;                                   // 桌号
    int nChairNO;                                   // 位置
    DWORD dPGCH[TOTAL_CHAIRS];
    int nReserved[4];
} AUCTION_DINGQUE, *LPAUCTION_DINGQUE;

typedef struct _tagPRE_SAVE_RESULT
{
    int nFlag;
    int nHuStatus;
    int nOldScores[TOTAL_CHAIRS];                   // 旧积分
    int nOldDeposits[TOTAL_CHAIRS];                 // 旧银子
    int nScoreDiffs[TOTAL_CHAIRS];                  // 积分增减
    int nDepositDiffs[TOTAL_CHAIRS];                // 银子输赢
    int nIdlePlayerFlag;                            // 玩家状态;低位0～7位表示各个玩家状态，1为IdlePlayer，已经结算的空闲玩家，或者后来进入的空闲玩家
    int nChairNO;
    int nPreSaveAllDeposit;
    int nReserved[2];
} PRE_SAVE_RESULT, *LPPRE_SAVE_RESULT;

typedef struct _tagHU_ID_HEAD
{
    int nCount[TOTAL_CHAIRS];
    int nReserved[4];
} HU_ID_HEAD, *LPHU_ID_HEAD;

typedef struct _tagTransferInfo
{
    int nAniChairNo;                        //扣钱玩家chairNO
    int nDeposit[MAX_CHAIR_COUNT];          //银子输赢变化
} TRANSFER_INFO, *LPTRANSFER_INFO;

typedef struct _tagGIVEUP_INFO
{
    int nNeedDeposit;
    int nLastSecond;
    int nGiveUpChair[TOTAL_CHAIRS];
    int nReserved[4];
} GIVEUP_INFO, *LPGIVEUP_INFO;

typedef struct _tagPLAYER_RECHARGE
{
    int nUserID;                                // 用户ID
    int nRoomID;                                // 房间ID
    int nTableNO;                               // 桌号
    int nChairNO;                               // 位置
    int nDelayTime;                             // 延时时间
    int nReserved[4];
} PLAYER_RECHARGE, *LPPLAYER_RECHARGE;


typedef struct _tagGIVE_UP_GAME{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	BOOL bTimeOut;								// 超时
	int nReserved[4];
}GIVE_UP_GAME, *LPGIVE_UP_GAME;

// lua端自定义
typedef struct _tagAPPLY_WELFARE_OK {
    int nSendSilver;
}APPLY_WELFARE_OK, *LPAPPLY_WELFARE_OK;

// C++端的名字是APPLY_BASEWELFARE
typedef struct _tagAPPLY_WELFARE{
	int   nUserID;
	int   nRoomID;								// 房间ID
	int   nTableNO;								// 桌号
	int   nChairNO;								// 位置
	TCHAR szUserName[MAX_USERNAME_LEN];	
	DWORD dwIPAddr;
	int	  nActivityID;							// 活动ID
	int   nSaveTo;								// 0游戏 1后备箱
	DWORD dwSoapFlags;
	int   nSoapReturn;
	DWORD dwFlags;									
	int   nReserved[8];
}APPLY_WELFARE, *LPAPPLY_WELFARE;

