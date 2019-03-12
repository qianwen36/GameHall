// #include "MacroType.h"
typedef unsigned int       DWORD;
typedef int                 BOOL;
typedef char                TCHAR, *PTCHAR;
typedef unsigned char       BYTE;

// #define		MAX_CHAIR_COUNT			8			// 每张桌子的最多椅子数,每个游戏最多16人
// #define		MAX_CHAIRS_PER_TABLE	MAX_CHAIR_COUNT		// 每张桌子的最多椅子数
// #define		MAX_LEVELNAME_LEN		16			// 级别名称长度
// #define  	MAX_RESULT_COUNT        30          // 最多纪录30局游戏结果
// #define		MAX_USERNAME_LEN		32			// 用户名最长长度(含NULL)
// #define		MAX_CARDS_PER_CHAIR		64			// 每张椅子的最多牌张数    
// #define		MAX_HARDID_LEN			32			// 硬件标识ID最大长度
// #define		MAX_CARDS_LAYOUT_NUM	64			// 牌的方阵长度
// #define		MAX_HARDID_LEN_EX		32			// 硬件标识ID最大长度
// #define		MAX_GAMENAME_LEN		32	
// #define		MAX_NICKNAME_LEN		16			// 用户昵称最长长度(含NULL)
// #define		MAX_CHATMSG_LEN			64			// 聊天内容长度
// #define  	MAX_IM_MSG_ID_LEN	    64
// #define		MAX_SYSMSG_LEN			1024		// 最大系统ID
// #define		STR_HEADURL_MAX           128 
// #define		STR_LBSINFO_MAX           256 
// #define		STR_THIRDNAME_MAX		  128
enum BaseGameConst {
	MAX_CHAIR_COUNT			=8,			// 每张桌子的最多椅子数,每个游戏最多16人
	MAX_CHAIRS_PER_TABLE	=MAX_CHAIR_COUNT,		// 每张桌子的最多椅子数
	MAX_LEVELNAME_LEN		=16,			// 级别名称长度
	MAX_RESULT_COUNT        =30,          // 最多纪录30局游戏结果
	MAX_USERNAME_LEN		=32,			// 用户名最长长度(含NULL)
	MAX_CARDS_PER_CHAIR		=64,			// 每张椅子的最多牌张数    
	MAX_HARDID_LEN			=32,			// 硬件标识ID最大长度
	MAX_CARDS_LAYOUT_NUM	=64,			// 牌的方阵长度
	MAX_HARDID_LEN_EX		=32,			// 硬件标识ID最大长度
	MAX_GAMENAME_LEN		=32,	
	MAX_NICKNAME_LEN		=16,			// 用户昵称最长长度(含NULL)
	MAX_CHATMSG_LEN			=64,			// 聊天内容长度
	MAX_IM_MSG_ID_LEN	    =64,
	MAX_SYSMSG_LEN			=1024,		// 最大系统ID
	STR_HEADURL_MAX         =128, 
	STR_LBSINFO_MAX         =256, 
	STR_THIRDNAME_MAX		=128,
};

typedef struct _tagGAME_WIN{	
	DWORD dwWinFlags;											// 输赢标志
	DWORD dwNextFlags;											// 下一局标志
	int	nTotalChairs;											// 椅子数目	
	int	nBoutCount;												// 第几局
	int	nBanker;												// 庄家位置
	int	nPartnerGroup[MAX_CHAIRS_PER_TABLE];					// 所属组
	BOOL bBankWin;												// 庄家输赢
	int nWinPoints[MAX_CHAIRS_PER_TABLE];						// 输赢点数
	int	nBaseScore;												// 基本积分
	int	nBaseDeposit;											// 基本银子
	int	nOldScores[MAX_CHAIRS_PER_TABLE];						// 旧积分
	int	nOldDeposits[MAX_CHAIRS_PER_TABLE];						// 旧银子
	int	nScoreDiffs[MAX_CHAIRS_PER_TABLE];						// 积分增减	
	int	nDepositDiffs[MAX_CHAIRS_PER_TABLE];					// 银子输赢
	int nWinFees[MAX_CHAIRS_PER_TABLE];							// 手续费
	int	nLevelIDs[MAX_CHAIRS_PER_TABLE];						// 级别ID
	TCHAR szLevelNames[MAX_CHAIRS_PER_TABLE][MAX_LEVELNAME_LEN];// 级别名称
	int nNextBaseDeposit;										// 下一局的基础银子
	int nIdlePlayerFlag;										// 玩家状态;低位0～7位表示各个玩家状态，1为IdlePlayer，已经结算的空闲玩家，或者后来进入的空闲玩家
	int	nReserved[2];
}GAME_WIN, *LPGAME_WIN;

typedef struct _tagAsk_NewTableChair{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	int nReserved[4];
}ASK_NEWTABLECHAIR, *LPASK_NEWTABLECHAIR;

// c++ 那边的 数据结构 bNeedEcho名字是nVerifyKey
typedef struct _tagGAME_MSG
{
    int   nRoomID;
    int   nUserID;                    // 用户ID            4
    int   nMsgID;                     // 消息号            4
    int   bNeedEcho;                 // 验证码            4
    int   nDatalen;                   // 数据长度          4
} GAME_MSG, *LPGAME_MSG;

typedef struct _tagENTER_GAME_EX{
	int nUserID;								// 用户ID
	int nUserType;								// 用户类型
	int	nGameID;								// 游戏ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	TCHAR szHardID[MAX_HARDID_LEN_EX];			// 硬件标识
	BOOL bLookOn;								// 旁观
	DWORD nRoomConfigs;
	int nGameVID;
	DWORD dwParentGameCode;						// 游戏缩写[就是那个四个字母]
	DWORD dwUserConfigs;						// 游戏设置
	int nReserved2[3];
	int nRoomTokenID;							// 房间令牌ID
	int nMbNetType;								// 手机网络类型
	int nMatchId;								// 比赛ID
	int nParentGameId;                          // 宿主游戏ID 【新增】
	int nReserved3[1];
}ENTER_GAME_EX, *LPENTER_GAME_EX;

typedef struct _tagGAME_ABORT{
	int nUserID;								// 用户ID
	int nChairNO;								// 断线人位置
	BOOL bForce;								// 强行退出
	int	nOldScore;								// 旧积分
	int	nOldDeposit;							// 旧银子
	int nScoreDiff;								// 积分增减
	int nDepositDfif;							// 银子输赢
	int nTableNO;								// 桌号
	int nAbortFlag;								// ASK_EXIT_FLAG表示是协商退出
	int nReserved[2];
}GAME_ABORT, *LPGAME_ABORT;

typedef struct _tagENTER_INFO
{
	int    nRoomID;												 //房间号
	int	   nTableNO;											 //桌号
	int    nTotalChair;											 //玩家数

	int	   nBaseScore;											 //本局基本积分
	int	   nBaseDeposit;										 //本局基本银子

	DWORD  dwUserStatus[MAX_CHAIRS_PER_TABLE];					 //玩家状态
	int    nBout;												 //当前局数

	int	   nKickOffTime;										 //踢客户端超时		
	int	   nReserved[7];
}ENTER_INFO,*LPENTER_INFO;

typedef struct _tagGAME_ENTER_INFO{
	ENTER_INFO     ei;
	int            nResultDiff[MAX_CHAIR_COUNT][MAX_RESULT_COUNT];
	int			   nTotalResult[MAX_CHAIR_COUNT];
	int            nReserve[4];
}GAME_ENTER_INFO,*LPGAME_ENTER_INFO;

typedef struct _tagGETVERSION_MB{          //此结构必须固定长度,应对版本升级
	char szExeName[MAX_GAMENAME_LEN];
	int nReserved[4];
}GETVERSION_MB, *LPGETVERSION_MB;

typedef struct _tagCHECKVERSION_MB{          //此结构必须固定长度,应对版本升级
	char szExeName[MAX_GAMENAME_LEN];
	int nExeMajorVer;
	int nExeMinorVer;
	int nExeBuildno;
	int nReserved[4];
}CHECKVERSION_MB, *LPCHECKVERSION_MB;

typedef struct _tagSENDER_INFO{
	int nSendTable;								// 发送者桌号
	int nSendChair;								// 发送者位置
	int nSendUser;								// 发送者ID
	TCHAR szHardID[MAX_HARDID_LEN];				// 硬件标识
	int nReserved[4];
}SENDER_INFO, *LPSENDER_INFO;

typedef struct _tagLEAVE_GAME{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	BOOL bPassive;								// 是否被动
	SENDER_INFO sender_info;					// 发送者信息
	DWORD dwFlag;
	int nReserved[3];
}LEAVE_GAME, *LPLEAVE_GAME;

typedef struct _tagSoloPlayerHead{
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nPlayerCount;							// 已上桌玩家数
	DWORD dwUserStatus[MAX_CHAIRS_PER_TABLE];	// 玩家状态
	int nReserved[4];
}SOLOPLAYER_HEAD, *LPSOLOPLAYER_HEAD;

typedef struct _tagSOLO_PLAYER{
	int nUserID;								// 用户ID
	int nUserType;								// 用户类型
	int nStatus;								// 玩家状态
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	int nNickSex;								// 显示性别 -1: 未知; 0: 男性; 1: 女性
	int nPortrait;								// 头像
	int nNetSpeed;								// 网速
	int nClothingID;							// 服装ID
	TCHAR szUsername[MAX_USERNAME_LEN];			// 用户名
	TCHAR szNickName[MAX_NICKNAME_LEN];			// 绰号
	int	nDeposit;								// 银子
	int nPlayerLevel;							// 级别
	int nScore;									// 积分
	int nBreakOff;								// 断线
	int nWin;									// 赢
	int nLoss;									// 输
	int nStandOff;								// 和
	int nBout;									// 回合
	int nTimeCost;								// 花时
	BOOL bRefuse;								// 是否拒绝旁观
	int nReserved[3];
}SOLO_PLAYER, *LPSOLO_PLAYER;

typedef struct _tagSTART_GAME{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	int nMatchId;								// 比赛的ID
	int nReserved[3];
}START_GAME, *LPSTART_GAME;

typedef struct _tagSTART_TEAM_READY{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	int nReserved[4];
}START_TEAM_READY, *LPSTART_TEAM_READY;

typedef struct _tagCANCEL_TEAM_MATCH{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	int nReserved[4];
}CANCEL_TEAM_MATCH, *LPCANCEL_TEAM_MATCH;

typedef struct _tagUser_Position{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	int nPlayerCount;							// 已上桌玩家数
	DWORD dwUserStatus[MAX_CHAIRS_PER_TABLE];	// 玩家状态
	DWORD dwTableStatus;
	int	  nCountdown;
	int   nReserved[2];
}USER_POSITION, *LPUSER_POSITION;

typedef struct _tagGAME_PULSE
{
	int nUserID;
	DWORD dwAveDelay;							// 1分钟内的平均延迟
	DWORD dwMaxDelay;							// 单次通讯最大延迟
	int nReserved[1];
}GAME_PULSE,*LPGAME_PULSE;

// lua 自定义数据
typedef struct _LEAVE_GAME_TOOFAST
{
    int nSecond;
}LEAVE_GAME_TOOFAST, *LPLEAVE_GAME_TOOFAST;

typedef struct _tagCHAT_FROM_TABLE{
	int nUserID;								// 发送者ID
	int nRoomID;								// 房间ID
	DWORD dwFlags;
	int nHeadLen;
	int nReserved[4];
	int nMsgLen;								// 短信长度
	TCHAR szChatMsg[MAX_CHATMSG_LEN*2];
}CHAT_FROM_TABLE,*LPCHAT_FROM_TABLE;

typedef struct _tagTALK_TO_TABLE{
	int nUserID;                                // 用户ID
	int nRoomID;                                // 房间ID
	int nTableNO;                               // 桌号
	int nChairNO;                               // 说话人位置
	int nTalkType;                              // ETalkType
	TCHAR szMsgID[MAX_IM_MSG_ID_LEN];           // 消息ID
	TCHAR szHardID[MAX_HARDID_LEN];             // 硬件标识ID
	DWORD dwTalkFlag;							// ETalkFlag
	int nReserved[7];
	int nMsgLen;                                // 信息内容长度 < MAX_TALKMSG_LEN
	//TCHAR szTalkMsg[1];                         // 信息内容[动态长度]
}TALK_TO_TABLE, *LPTALK_TO_TABLE;

typedef struct _tagTALK_FROM_TABLE{
	int nUserID;                                // 发送者ID
	int nRoomID;                                // 房间ID
	DWORD dwFlags;
	int nTalkType;                              // ETalkType
	TCHAR szMsgID[MAX_IM_MSG_ID_LEN];           // 消息ID
	DWORD uTimeStampS;                          // 时间戳-秒的部分
	DWORD uTimeStampMS;                         // 时间戳-毫秒的部分
	int nReserved[8];
	int nMsgLen;                                // 信息内容长度 < MAX_TALKMSG_LEN
	//TCHAR szTalkMsg[1];                         // UTF8(敏感字内容会由‘*’代替)
}TALK_FROM_TABLE, *LPTALK_FROM_TABLE;

typedef struct _tagTALK_TABLE_ERROR{
	int nUserID;                                // 发送者ID
	int nRoomID;                                // 房间ID
	DWORD dwFlags;
	int nErrType;                               // ETalkError
	int nTalkType;                              // ETalkType
	TCHAR szMsgID[MAX_IM_MSG_ID_LEN];           // 消息ID
	int nMsgLen;                                // 信息内容长度 < MAX_TALKMSG_LEN
	int nReserved[8];
	//TCHAR szTalkMsg[1];                         // 例子："本游戏禁止旁观者发消息"
}TALK_TABLE_ERROR, *LPTALK_TABLE_ERROR;

typedef struct _tagDEPOSIT_NOT_ENOUGH{
	int nUserID;								// 用户ID
	int nChairNO;								// 位置
	int nDeposit;								// 银子
	int nMinDeposit;							// 最少需要银子
	int nReserved[4];
}DEPOSIT_NOT_ENOUGH, *LPDEPOSIT_NOT_ENOUGH;

typedef struct _tagDEPOSIT_TOO_HIGH{
	int nUserID;								// 用户ID
	int nChairNO;								// 位置
	int nDeposit;								// 银子
	int nMaxDeposit;							// 银子上限
	int nReserved[4];
}DEPOSIT_TOO_HIGH, *LPDEPOSIT_TOO_HIGH;

typedef struct _tagSCORE_NOT_ENOUGH{
	int nUserID;								// 用户ID
	int nChairNO;								// 位置
	int nScore;									// 积分
	int nMinScore;								// 最少需要积分
	int nReserved[4];
}SCORE_NOT_ENOUGH, *LPSCORE_NOT_ENOUGH;

typedef struct _tagSCORE_TOO_HIGH{
	int nUserID;								// 用户ID
	int nChairNO;								// 位置
	int nScore;									// 积分
	int nMaxScore;								// 最大允许积分
	int nReserved[4];
}SCORE_TOO_HIGH, *LPSCORE_TOO_HIGH;

typedef struct _tagUSER_BOUT_TOO_HIGH{
	int nUserID;								// 用户ID
	int nChairNO;								// 位置
	int nBout;									// 局数
	int nMaxBout;								// 最大允许局数
	int nReserved[4];
}USER_BOUT_TOO_HIGH, *LPUSER_BOUT_TOO_HIGH;

typedef struct _tagTABLE_BOUT_TOO_HIGH{
	int nTableNO;								// 桌子位置
	int nBout;									// 局数
	int nMaxBout;								// 最大允许局数
	int nReserved[4];
}TABLE_BOUT_TOO_HIGH, *LPTABLE_BOUT_TOO_HIGH;

typedef struct _tagGAME_UNABLE_TO_CONTINUE{
	int nMsgLen;								// 长度
	int nReserved;								// 
	TCHAR szCause[MAX_SYSMSG_LEN]; 				// 客户端弹出框内容	 
}GAME_UNABLE_TO_CONTINUE, *LPGAME_UNABLE_TO_CONTINUE;

typedef struct _tagUser_DepositEvent{
	int nUserID;
	int nChairNO;
	int nEvent;	
	int	nDepositDiff;
	int nDeposit;
	int nBaseDeposit;
	int nReserved[4];
}USER_DEPOSITEVENT, *LPUSER_DEPOSITEVENT;

typedef struct _tagLOOK_SAFE_DEPOSIT{
	int nUserID;								// 用户ID
	int nGameID;
	DWORD dwIPAddr;                             // IP地址
	TCHAR szHardID[MAX_HARDID_LEN_EX];			// 硬件标识符（网卡序列号）	
	int nReserved[8];
}LOOK_SAFE_DEPOSIT, *LPLOOK_SAFE_DEPOSIT;

typedef struct _tagSAFE_DEPOSIT_EX{
	int  nUserID;
	int  nDeposit;								// 银子
	BOOL bHaveSecurePwd;                        // 是否有保护密码
	int  nRemindDeposit;                        // 超过这个银子，就提醒要设置保护密码
	int  nKeepDeposit;							// [新增]本游戏划银银两限制
	int  nReserved[3];
}SAFE_DEPOSIT_EX, *LPSAFE_DEPOSIT_EX;

// C++ 数据结构名称 TAKE_SAFE_DEPOSIT
typedef struct _tagTAKESAVE_SAFE_DEPOSIT{
	int nUserID;								// 用户ID
	int nGameID;								// 游戏ID
	int nRoomID;
	int nTableNO;
	int nChairNO;	
	int nDeposit;								// 银子
	int nKeyResult;								// 计算结果 = func(保护密码, 随机数)
	int nPlayingGameID;                         
	int nGameVID;
	int nTransferTotal;							// 划入这个游戏的总和(扣除划出的)，注意可能为负值，
	int nTransferLimit;							// 划入这个游戏，限定数量(两,>0)。
	DWORD dwIPAddr;                             // IP地址
	TCHAR szHardID[MAX_HARDID_LEN_EX];			// 硬件标识符（网卡序列号）	
	int nGameDeposit;
	DWORD dwFlags;								// 是否支持GR_KEEPDEPOSIT_LIMIT_EX 和 GR_INPUTLIMIT_MONTHLY_EX
	long long llMonthTransferTotal;				// 本月划入游戏的总和(扣除划出的)，注意可能为负值，
	long long llMonthTransferLimit;				// 本月划入游戏，限定数量(两,>0)
	int nParentGameId;							// 宿主游戏ID
	int nUserType;
}TAKESAVE_SAFE_DEPOSIT, *LPTAKESAVE_SAFE_DEPOSIT;

typedef struct _tagSOLO_TABLE{
	int		nRoomID;
	int		nTableNO;
	int		nUserCount;
	int		nUserIDs[MAX_CHAIR_COUNT];
	int		nReserved[5];
}SOLO_TABLE, *LPSOLO_TABLE;

typedef struct _tagGET_TABLE_INFO{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	DWORD dwFlags;								// 标示位
	int nReserved[3];
}GET_TABLE_INFO, *LPGET_TABLE_INFO;

typedef struct _tagENTER_BKG_MB{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	DWORD dwFlag;								// 类型
	int nRecordTime;							// 记录时间
	int nReserved[4];
}ENTER_BKG_MB, *LPENTER_BKG_MB;

typedef struct _tagSAFE_RNDKEY{
	int nUserID;
	int nRndKey;
	int nReserved[4];
}SAFE_RNDKEY, *LPSAFE_RNDKEY;

typedef struct _tagASK_ONLY_CHANGE_CHAIR{ // 请求同桌换椅子
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	int nToChairNO;								// 新位置
	int nReserved[4];
}ASK_ONLY_CHANGE_CHAIR, *LPASK_ONLY_CHANGE_CHAIR;

typedef struct _tagSOMEONE_NEWCHAIR{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nOldChairNO;							// 之前位置
	int nNewChairNO;							// 现在位置
	int nReserved[4];
}SOMEONE_NEWCHAIR, *LPSOMEONE_NEWCHAIR;

typedef struct _tagHOME_TICK_PLAYER{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;
	int nTickModel;								// 踢人模式 0 主动 ， 1 时间到
	int nTargetUserID;							// 被踢的目标
	int nTargetChairNO;							// 被踢的目标
	int nReserved[4];
}HOME_TICK_PLAYER, *LPHOME_TICK_PLAYER;

typedef struct _tagTELLLIENT_KICKOFF_EX{
	int nHomeUserID;							// 用户ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nChairNO;								// 被踢人的桌号
	int nUserID;
	int nTickModel;								// 踢人模式 0 主动 ， 1 时间到
	int nReserved[4];
}TELLLIENT_KICKOFF_EX, *LPTELLLIENT_KICKOFF_EX;

typedef struct _tagTELLLIENT_HOMEUSERCHANGED{
	int nHomeUserID;							// 新房主ID
	int nRoomID;								// 房间ID
	int nTableNO;								// 桌号
	int nReserved[4];
}TELLLIENT_HOMEUSERCHANGED, *LPTELLLIENT_HOMEUSERCHANGED;

typedef struct _tagSYNCH_SOCLALLY_INFO{
	int   nUserID;
	int   nGameID;
	int   nRoomID;
	int   nTableNO;
	int   nChairNO;
	TCHAR szHeadUrl[STR_HEADURL_MAX]; //url
	TCHAR szLBSInfo[STR_LBSINFO_MAX]; //lbs
	int   nReserved[8];
}SYNCH_SOCLALLY_INFO, *LPSYNCH_SOCLALLY_INFO;

// 某一个玩家的附加信息
typedef struct _tagONE_PLAYER_SOCLALLY{
	int nUserID;
	TCHAR szHeadUrl[STR_HEADURL_MAX]; //url
	TCHAR szLBSInfo[STR_LBSINFO_MAX]; //lbs
}ONE_PLAYER_SOCLALLY, *LPONE_PLAYER_SOCLALLY;

typedef struct _tagTELLCLIENT_SOCLALLY{
	int   nCount;
	int   nReserved[8];
}TELLCLIENT_SOCLALLY, *LPTELLCLIENT_SOCLALLY;

// c++ 数据结构名称 TELLHOMEINFOONDXXW
typedef struct _tagTELL_HOMEINFO_ONDXXW{
	int   nHomeUserID;
	int   nHomeChairID;
	int   nEnterFlag;
	int   nReserved[3];
}TELL_HOMEINFO_ONDXXW, *LPTELL_HOMEINFO_ONDXXW;

// 货币变化到游戏
//存放货币的容器
typedef enum
{
		TCY_CURRENCY_CONTAINER_COFFER = 0,	//保险箱
		TCY_CURRENCY_CONTAINER_BACK,		//后备箱
		TCY_CURRENCY_CONTAINER_GAME,		//游戏
} TCY_CURRENCY_CONTAINER;

//货币
typedef enum
{
		TCY_CURRENCY_DEPOSIT = 0,			//银子
		TCY_CURRENCY_SCORE,					//积分
		TCY_CURRENCY_TONGBAO,				//通宝
		TCY_CURRENCY_GAMECOIN,				//游戏自定义货币
} TCY_CURRENCY;

// c++ 那边llOperationID和llBalance 是 long long类型
typedef struct _tagCURRENCY_EXCHANGE{
	int						nUserID;
	TCY_CURRENCY_CONTAINER	nContainer;					
	TCY_CURRENCY			nCurrency;				
	int						nExchangeGameID;
    int                     llOperationIDLow;
    int                     llOperationIDHigh;
	int                     llBalanceLow;
    int                     llBalanceHigh;
	int						nOperateAmount;			//操作数量
	int						nCreateTime;
	DWORD					dwFlags;
	
	int						nReserved[8];
}CURRENCY_EXCHANGE, *LPCURRENCY_EXCHANGE;

typedef struct _tagCURRENCY_EXCHANGE_EX{
	CURRENCY_EXCHANGE		currencyExchange;
	
	DWORD					dwNotifyFlags;
	int						nEnterRoomID;			//通知时带上的玩家所在房间roomid，和本次变化无关
	
	int						nReserved[16];
}CURRENCY_EXCHANGE_EX, *LPCURRENCY_EXCHANGE_EX;

//PayToGame event
typedef struct _tagUser_CURRENCY_EXCHANGE{
	CURRENCY_EXCHANGE_EX	stExchangeMsg;
	int						nChairNO;
	int						nReserved[4];
}USER_CURRENCY_EXCHANGE, *LPUSER_CURRENCY_EXCHANGE;

//
typedef struct _tagVERSION{
	int nMajorVer;								// 主版本号
	int nMinorVer;								// 子版本号
	int nBuildNO;								// 生成日期
	int nReserved[4];
}VERSION, *LPVERSION;

typedef struct _tagADJUST_TABLE_CHAIR{
    int nRoomId;
    int nTableNO;
    int nPlayerAry[MAX_CHAIRS_PER_TABLE];  // 每张椅子对应的新玩家
    int nReserved[8];
}ADJUST_TABLE_CHAIR, *LPADJUST_TABLE_CHAIR;

typedef struct  _tagMODIFY_TABLEANDCHAIR
{
    int     nUserID;                               // 用户ID
    int     nRoomID;                               // 房间ID
    int     nTableNO;                              // 桌号
    int     nChairNO;                              // 位置
    int     nReserved[8];
} MODIFY_TABLEANDCHAIR, *LPMODIFY_TABLEANDCHAIR;

typedef struct _tagROOM_PROMPT_LINE
{
    int nUserID;                // 用户ID
    int nRoomID;                // 房间ID
    int nTableNO;               // 桌号
    int nChairNO;               // 位置
    int nRoomPromptLine;        // 房间提示线
    int nReserved[4];
} ROOM_PROMPT_LINE, *LPROOM_PROMPT_LINE;

