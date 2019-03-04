import('.predefine')

require('ffi').cdef[[

typedef struct _tagHALLUSER_PULSE{
	int nUserID;								// 呼叫者ID
	int nAgentGroupID;								// 房间ID
}HALLUSER_PULSE, *LPHALLUSER_PULSE;


typedef struct _tagROOMUSER_PULSE{
	int nUserID;								// 
	int nRoomID;								//  
}ROOMUSER_PULSE, *LPROOMUSER_PULSE;


typedef struct _tagVERSION_MB{          //此结构必须固定长度,应对版本升级
	int nMajorVer;
	int nMinorVer;
	int nBuildNO;
	int nGameID;
 	char szExeName[MAX_GAMENAME_LEN];
	int nReserved[4];
}VERSION_MB, *LPVERSION_MB;


typedef struct _tagCHECK_VERSION_OK_MB{       //此结构必须固定长度,应对版本升级
	int nMajorVer;
	int nMinorVer;
	int nBuildNO;
	int nCheckReturn;               
	char szDLFile[MAX_DLFILENAME_LEN];      //需要下载的安装包文件名(包括后缀)
	char szUpdateWWW[MAX_WWW_LEN];
	T_DWORD  dwClientIP;//返回客户端外网IP
	int nReserved[4];
}CHECK_VERSION_OK_MB, *LPCHECK_VERSION_OK_MB;


typedef struct _tagGET_SERVERS{  //此结构必须固定长度和字段顺序,应对版本升级
	int nGameID;
	int nServerType;	    // 1: 游戏服务器；  3: 下载服务器；
	int nSubType;
	int nAgentGroupID;
	T_DWORD dwGetFlags;
	int nReserved[3];
}GET_SERVERS, *LPGET_SERVERS;
 
typedef struct _tagSERVERS{          //此结构长度,字段顺序必须固定,应对版本升级
	int nServerCount;
	int nReserved[4];
}SERVERS, *LPSERVERS;
 
typedef struct _tagSERVER{   //此结构长度,字段顺序必须固定,应对版本升级,
	int nServerID;
	int nServerType;
	T_TCHAR szServerName[MAX_SERVERNAME_LEN];
	T_TCHAR szServerIP[MAX_SERVERIP_LEN];
	T_TCHAR szWWW[MAX_WWW_LEN];
	T_TCHAR szWWW2[MAX_WWW_LEN];
	int nUsersOnline;
	int nGroupID;
	int nSubType;
	int nPort;
	int nLayOrder;
	int nStatus;
	T_DWORD dwOptions;
	int nReserved[2];
}SERVER, *LPSERVER;
 

typedef struct _tagGET_AREAS{
 	int nGameID;
	int nAreaType;
	int nSubType;
	int nAgentGroupID;
	T_DWORD dwGetFlags;
	T_DWORD dwVersion;
 	int nReserved[3];
}GET_AREAS, *LPGET_AREAS;

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

typedef struct _tagGET_ROOMS{
 	int nAreaID;
	int nGameID;
  	int nAgentGroupID;
	T_DWORD dwGetFlags;
 	int nReserved[4];
}GET_ROOMS, *LPGET_ROOMS;

typedef struct _tagROOMS{
	int nRoomCount;
	int nLinkCount;
	int nReserved[2];
}ROOMS, *LPROOMS;

typedef struct _tagROOM{
	int nRoomID;
	int nRoomType;
	int nSubType;
	int nStatus;
 	int nLayOrder;
 	T_DWORD dwOptions;
	int nFontColor;
	int nIconID;
	int nGifID;//以上9个为对象固定字段
	int nGameID;
	int nGameVID;
	int nGameDBID; 
	int nMatchID;
	int nAreaID;
 	int nPort;
	int nGamePort;
	int nTableID;
	int nTableIDPlay;
	int nTableStyle;
	int nBoyClothing;
	int nGirlClothing;
  	int nTableCount;
	int nChairCount;
	int nUsersOnline;
	int nMinScore;
	int nMaxScore;
	int nMinPlayScore;
	int nMaxPlayScore;
  	int nMinDeposit;
	int nMaxDeposit;
	int nMinLevel;
	int nMinExperience;
	int nMaxUsers;
	int nExeMajorVer;
	int nExeMinorVer;
	int nInactiveSecond; 
	int nHallBuildNO; 
	int nGiftScore;
	int nGiftDeposit;
	int nGameParam;
	int nGameData;
	int nMinSalarySecond;
	int nMaxSalarySecond;
	int nUnitSalary;
	int nMinBoutSecond;
	int nMaxBoutSecond;
	T_DWORD dwConfigs;
	T_DWORD dwManages; 
	T_DWORD dwGameOptions;
	T_TCHAR szRoomName[MAX_ROOMNAME_LEN];
	T_TCHAR szGameIP[MAX_SERVERIP_LEN];
	T_TCHAR szPassword[MAX_PASSWORD_LEN];
	T_TCHAR szWWW[MAX_WWW_LEN];
	T_TCHAR szExeName[MAX_GAMENAME_LEN];
	T_DWORD dwActivityClothings;	//低位 男生服装， 高位 女生服装
	int nClientID;
	int nReserved[6];
}ROOM, *LPROOM;

typedef struct _tagGET_GAMELEVEL{
	int nGameID;
 	int nReserved[4];
}GET_GAMELEVEL, *LPGET_GAMELEVEL;

 
typedef struct _tagGAME_LEVEL{
 	int nGameID;
 	T_TCHAR szLevelInfo[MAX_LEVELINFO_LEN];
	int nReserved[4];
}GAME_LEVEL, *LPGAME_LEVEL;


typedef struct _tagGET_ROOMUSERS{
	int nAgentGroupID;
	T_DWORD dwGetFlags;
  	int nReserved[3];
	int nRoomCount;//该结构发送时变长
//	int nRoomID[MAX_QUERY_ROOMS];
}GET_ROOMUSERS, *LPGET_ROOMUSERS;

typedef struct _tagITEM_COUNT{
 	int nCount;
	int nStatTime;//2038秒
	int nSubCount;
	T_DWORD dwGetFlags;
  	int nReserved[1];
}ITEM_COUNT, *LPITEM_COUNT;


typedef struct _tagITEM_USERS{
	int nItemID;
	int nUsers;
}ITEM_USERS, *LPITEM_USERS;

typedef struct _tagQUERY_USERID{
	int  nAgentGroupID;
	int  nUserID;
	T_TCHAR szUsername[MAX_USERNAME_LEN];	
	T_TCHAR szHardID[MAX_HARDID_LEN];	
	T_DWORD dwIPAddr; 
	int nReserved[3];
}QUERY_USERID, *LPQUERY_USERID;


typedef struct _tagQUERY_USERID_OK{
	int nUserID;
	int nReserved[4];
}QUERY_USERID_OK, *LPQUERY_USERID_OK;


typedef struct _tagREG_USER_MB{
	int   nAgentGroupID;		            	// 组编号
	int   nUserID;
	int   nUserType;						 	// 用户类型 0: 普通; 1: 会员
	int   nSubType;								// 子类型
	int   nNickSex;								// 显示性别 -1: 未知; 0: 男性; 1: 女性
	int   nPortrait;					    	// 头像
	int   nClothingID;
	T_DWORD dwRegFlags;
    int   nReserved[3];
 	T_DWORD dwSysVer;                             //操作系统版本
	T_DWORD dwIPAddr;                              //IP地址
 	char  szUsername[MAX_USERNAME_LEN];			// 用户名
  	char  szRndKey[MAX_RNDKEY_LEN_EX];
    char  szPassword[MAX_PASSWORD_LEN];			// 口令
	char  szHandPhone[MAX_TELNO_LEN];			// 手机号
	char  szWifiID[MAX_HARDID_LEN];			 // wifi网卡,hardid
	char  szSystemID[MAX_HARDID_LEN];	     // 系统ID,volumeid
 	char  szImeiID[MAX_HARDID_LEN];           // imei,15位数字,machineid
	char  szImsiID[MAX_HARDID_LEN];           // imsi,从SIM卡读取
	char  szSimSerialNO[MAX_HARDID_LEN];      // sim卡序列号,从SIM卡读取
   	int   nVerifyReturn;                         //是否通过认证 
	int   nGiftDeposit;                          //注册赠送
	int   nRecommenderID;
	int   nGameID;
	int   nReserved2[7];
}REG_USER_MB, *LPREG_USER_MB;


typedef struct _tagREG_USER_OK_MB{
	int nUserID;
	int nReserved[4];
}REG_USER_OK_MB, *LPREG_USER_OK_MB;


 
typedef struct _tagLOGON_USER{
	int  nBlockSvrID;
 	int  nUserID;
	int  nHallSvrID;
	int  nAgentGroupID;
	int  nGroupType;
 	T_DWORD dwIPAddr;
	T_DWORD dwSoapFlags;
 	T_DWORD dwLogonFlags;
 	T_LONG lTokenID;
 	T_UINT nResponse;
	T_TCHAR szUsername[MAX_USERNAME_LEN];
    T_TCHAR szPassword[MAX_PASSWORD_LEN];
	T_TCHAR szHardID[MAX_HARDID_LEN];
	T_TCHAR szVolumeID[MAX_HARDID_LEN];
	T_TCHAR szMachineID[MAX_HARDID_LEN]; 
    T_TCHAR szHashPwd[DEF_HASHPWD_LEN+2];
 	T_TCHAR szRndKey[MAX_RNDKEY_LEN_EX];
  	T_DWORD dwSysVer; 
 	int  nLogonSvrID; 
	int  nHallBuildNO;
  	int  nHallNetDelay;
	int  nHallRunCount;
	int	 nGameID;
	T_DWORD dwGameVer;
	int	 nRecommenderID;
   	int  nChannelID;
}LOGON_USER, *LPLOGON_USER;


typedef struct _tagLOGOFF_USER{
	int nUserID;
	int nHallSvrID;
	int nAgentGroupID;
	T_DWORD dwIPAddr;
	T_DWORD dwLogoffFlags;
	T_LONG lTokenID;
 	T_TCHAR szHardID[MAX_HARDID_LEN];
	T_TCHAR szVolumeID[MAX_HARDID_LEN];
 	T_TCHAR szMachineID[MAX_HARDID_LEN]; 
	int nReserved[2];
}LOGOFF_USER, *LPLOGOFF_USER;


typedef struct _tagLOGON_SUCCEED{
	int nUserID;
 	int nNickSex;
	int nPortrait;
	int nUserType;
	int nClothingID;
	int nRegisterGroup;
	int nDownloadGroup;
	int nAgentGroupID;
	int nExpiration;
  	int nPlayRoom;
 	T_TCHAR szNickName[MAX_NICKNAME_LEN];
	T_TCHAR szUniqueID[MAX_UNIQUEID_LEN]; 
	int nMemberLevel;
	int nReserved[3];
}LOGON_SUCCEED, *LPLOGON_SUCCEED;

typedef struct _tagRESET_PASSWORD{
	int   nAgentGroupID;		            	// 组编号
	int   nUserID;
    int   nReserved[4];
 	T_DWORD dwIPAddr;                              //IP地址
 	char  szUsername[MAX_USERNAME_LEN];			// 用户名
  	char  szRndKey[MAX_RNDKEY_LEN_EX];
    char  szPassword[MAX_PASSWORD_LEN];			// 新口令
	char  szHandPhone[MAX_TELNO_LEN];			// 手机
	char  szWifiID[MAX_HARDID_LEN];			 // wifi网卡,hardid
	char  szSystemID[MAX_HARDID_LEN];	     // 系统ID,volumeid
 	char  szImeiID[MAX_HARDID_LEN];           // imei,15位数字,machineid
	char  szImsiID[MAX_HARDID_LEN];           // imsi,从SIM卡读取
	char  szSimSerialNO[MAX_HARDID_LEN];      // sim卡序列号,从SIM卡读取
  	int   nGameID;
	int   nReserved2[7];
}RESET_PASSWORD, *LPRESET_PASSWORD;


typedef struct _tagMOVE_SAFE_DEPOSIT{
	int nUserID;	
	int nGameID;
	int nRoomID;
	int nDeposit;
	int nKeyResult;								// 计算结果 = func(保护密码, 随机数)
	int nPlayingGameID;							//验证是否有游戏正在玩
	T_TCHAR szHardID[MAX_HARDID_LEN];
	T_DWORD dwIPAddr; 
	int nGameVID;
	int nTransferTotal;							//划入这个游戏的总和(扣除划出的)，注意可能为负值，
	int nTransferLimit;							//划入这个游戏，限定数量(两,>0)。
//#ifndef __SUPPORT_LONG_LONG__
// 	LONGLONG llMonthTransferTotal;				//本月划入游戏的总和(扣除划出的)，注意可能为负值，
//	LONGLONG llMonthTransferLimit;				//本月划入游戏，限定数量(两,>0)
//#else
	long long llMonthTransferTotal;				//本月划入游戏的总和(扣除划出的)，注意可能为负值，
	long long llMonthTransferLimit;				//本月划入游戏，限定数量(两,>0)
//#endif
	T_DWORD dwFlags;								//目前用于标记客户端是否支持GR_INPUTLIMIT_MONTHLY错误类型处理
	int nReserved[3];
}MOVE_SAFE_DEPOSIT, *LPMOVE_SAFE_DEPOSIT;

typedef struct _tagTRANSFER_DEPOSIT{
	int nUserID;
	int nFromGame;	
	int nToGame;								// 游戏ID	0: 保险箱
 	int nFromRoom;							
	int nToRoom;
	int nDeposit;
	int nPlayingGameID;                         //验证是否有游戏正在玩
	int nVerifyGame;                            //当前正在验证的游戏ID 
	T_TCHAR szHardID[MAX_HARDID_LEN];
	T_DWORD dwIPAddr; 
	int nGameVID;
	int nTransferTotal;//划入这个游戏的总和(扣除划出的)，注意可能为负值，
	int nTransferLimit;//划入这个游戏，限定数量(两,>0)。
	T_DWORD dwFlags;								// 目前用于标记客户端是否支持GR_KEEPDEPOSIT_LIMIT错误类型处理
 	int nReserved[7];
}TRANSFER_DEPOSIT, *LPTRANSFER_DEPOSIT;


typedef struct _tagTAKE_SALARY_DEPOSIT{
	int nUserID;
	int nGameID;
	int nRoomID;
	int nDeposit;							
	T_TCHAR szHardID[MAX_HARDID_LEN];	
	T_DWORD dwIPAddr;  
	int nGameVID;
	int nRemainDeposit;
	int nReserved[4];
}TAKE_SALARY_DEPOSIT, *LPTAKE_SALARY_DEPOSIT;

typedef struct _tagTAKE_GIFT_DEPOSIT{
	int nUserID;
	int nGameID;
	int nRoomID;
	int nDeposit;
	char  szHardID[MAX_HARDID_LEN];			 // wifi网卡,hardid
	char  szVolumeID[MAX_HARDID_LEN];	     // 系统ID,volumeid
 	char  szMachineID[MAX_HARDID_LEN];           // imei,15位数字,machineid
	T_DWORD dwIPAddr;
	T_DWORD dwGetFlags;
	T_DWORD dwSoapFlags;
   	int   nReserved[5];
	char  szRemark[MAX_REMARK_LEN];
}TAKE_GIFT_DEPOSIT, *LPTAKE_GIFT_DEPOSIT;

typedef struct _tagGIFT_DEPOSIT{
	int nUserID;
	T_DWORD dwGetFlags;
  	int nDeposit;
	int nNextSeconds;               //下次获取的时间间隔
   	int nReserved[6];
	int nRemarkLen;
	char szRemark[MAX_REMARK_LEN];
}GIFT_DEPOSIT, *LPGIFT_DEPOSIT;


typedef struct _tagGET_RNDKEY{
	int  nRegisterGroup;
 	int  nUserID;
	T_TCHAR szUsername[MAX_USERNAME_LEN];	
	T_TCHAR szHardID[MAX_HARDID_LEN];	
	T_DWORD dwIPAddr;
	T_DWORD dwGetFlags;
	int nReserved[5];
}GET_RNDKEY, *LPGET_RNDKEY;
 

typedef struct _tagGET_RNDKEY_OK{
	int nRndKey;
	int nReserved[4];
}GET_RNDKEY_OK, *LPGET_RNDKEY_OK;


typedef struct _tagQUERY_SAFE_DEPOSIT{
	int nUserID;
	T_TCHAR szHardID[MAX_HARDID_LEN];	
	T_DWORD dwIPAddr;
	int nGameID;
	int nReserved[2];
}QUERY_SAFE_DEPOSIT, *LPQUERY_SAFE_DEPOSIT;


typedef QUERY_SAFE_DEPOSIT   QUERY_SALARY_DEPOSIT;
typedef LPQUERY_SAFE_DEPOSIT LPQUERY_SALARY_DEPOSIT;


typedef struct _tagSAFE_DEPOSIT{
	int nUserID;
	int nDeposit;
	T_BOOL bHaveSecurePwd;
	int  nRemindDeposit;      //超过这个银子，就提醒要设置保护密码
	int nReserved[2];
}SAFE_DEPOSIT, *LPSAFE_DEPOSIT;


typedef struct _tagSALARY_DEPOSIT{
	int nUserID;
	int nGameID;
	int nDeposit;
	int nTotalSalary;
 	int nReserved[3];
}SALARY_DEPOSIT, *LPSALARY_DEPOSIT;


typedef struct _tagQUERY_USER_GAMEINFO{
	int nUserID;
	int nGameID;
	T_DWORD dwQueryFlags;
 	T_DWORD dwIPAddr;
	char szHardID[MAX_HARDID_LEN];
	int nGiftDeposit;
 	int nReserved[3];
}QUERY_USER_GAMEINFO, *LPQUERY_USER_GAMEINFO;

typedef struct _tagUSER_GAMEINFO_MB{
 	int nUserID;								// 用户ID
 	int nGameID;								// 游戏ID
 	int	nDeposit;								// 银子
	int nPlayerLevel;							// 级别
 	int nScore;									// 积分
	int nExperience;							// 经验(分钟，已废弃)
	int nBreakOff;								// 断线
 	int nWin;									// 赢
	int nLoss;									// 输
	int nStandOff;								// 和
	int nBout;									// 回合
	int nTimeCost;								// 花时(秒)
	int nSalaryTime;
	int nSalaryDeposit;
	int nTotalSalary;
  	int nReserved[8];                      
}USER_GAMEINFO_MB, *LPUSER_GAMEINFO_MB;//注意这个结构跟pc端的那个不同

 

typedef struct _tagUSER_ACTIVATE{
	int nUserID;								// 用户ID
	T_LONG lTokenID;
    T_TCHAR szPassword[MAX_PASSWORD_LEN];			// 口令
	T_TCHAR szWWW[MAX_WWW_LEN];
   	int   nReserved[8];
}USER_ACTIVATE, *LPUSER_ACTIVATE;

typedef struct _tagSYSTEM_MSG{
	int nMsgID;
	T_DWORD dwDlgSize;
	T_DWORD dwOptions;
	int nLifeTime;								//单位：秒
 	int nReserved[6];	
	int nAgentGroupID;                          //发消息到某个组
	int nRoomID;                                //发消息到某个房间
	int nClientID;
	int nMsgFrom;
	int nMsgTo;
	int nSendDate;
	int nSendTime;
	int nMsgLen;								// 消息长度
	T_TCHAR szMsgText[MAX_SYSMSG_LEN];			// 消息内容
}SYSTEM_MSG, *LPSYSTEM_MSG;



typedef struct _tagDXXW_ROOM{
	int  nAgentGroupID;
	int  nRoomID;
 	int  nGameID;
 	int  nAreaID;
 	T_TCHAR szRoomName[MAX_ROOMNAME_LEN];
	int  nReserved[4];
}DXXW_ROOM, *LPDXXW_ROOM;
 

typedef struct _tagGET_WEBSIGN{
  	int  nUserID;
	T_TCHAR szPassword[MAX_PASSWORD_LEN];
  	T_TCHAR szHardID[MAX_HARDID_LEN];
	T_DWORD dwIPAddr;
	T_DWORD dwSoapFlags;
	T_DWORD dwGetFlags;
	int nHallSvrID;
	T_LONG lTokenID;
	int  nReserved[1];
	int  nValidSecond;
 	T_TCHAR szWebSign[MAX_WEBSIGN_LEN];
}GET_WEBSIGN, *LPGET_WEBSIGN;


typedef struct _tagGET_WEBSIGN_OK{
	int nUserID;
	int nValidSecond; //有效时间,秒
	T_TCHAR szWebSign[MAX_WEBSIGN_LEN];
	T_DWORD dwGetFlags;
	int nReserved[3];
}GET_WEBSIGN_OK, *LPGET_WEBSIGN_OK;


typedef struct _tagPLAYER_POSITION{
	int nUserID;
 	int nTableNO;
	int nChairNO;
	int nNetDelay;
}PLAYER_POSITION, *LPPLAYER_POSITION;


typedef struct _tagENTER_ROOM{
 	int nUserID;								// 用户ID
 	int nAreaID;								// AreaID
	int nGameID;								// 游戏ID
	int nGameVID;
 	int nRoomID;								// 房间ID
 	int nRoomSvrID;
	int nExeMajorVer;
	int nExeMinorVer;                           //exe程序小版本
	int nEnterTime;                          //在roomsvr端记录的收到请求时间
   	T_DWORD dwIPAddr;                             //服务端看到的客户端IP
	T_DWORD dwEnterFlags;           
	T_TCHAR szHardID[MAX_HARDID_LEN];				// 硬件标识符（网卡序列号）
	T_TCHAR szVolumeID[MAX_HARDID_LEN];	 
 	T_TCHAR szMachineID[MAX_HARDID_LEN];
 	T_TCHAR szUniqueID[MAX_UNIQUEID_LEN];			// 
	T_TCHAR szPhysAddr[MAX_PHYSADDR_LEN];
	T_DWORD dwScreenXY;  
	T_DWORD dwClientPort;  //存放了客户端和服务端分别取到的2个客户端端口unsigned  short 
	T_DWORD dwServerPort;  //存放了客户端和服务端分别取到的2个服务端端口unsigned  short 
	T_DWORD dwClientSockIP;
	T_DWORD dwRemoteSockIP;
	T_DWORD dwClientLANIP;//本地局域网地址
	T_DWORD dwClientMask;//本地子网掩码
	T_DWORD dwClientGateway;//本地网关地址
	T_DWORD dwClientDNS;//本地dns地址
	T_DWORD dwPixelsXY;
	T_DWORD dwClientFlags;//客户端标志
	int   nHostID;//roomsvr机器编号
	int   nQuanID;
	int   nExeBuildno;
   	int   nReserved[3];
}ENTER_ROOM, *LPENTER_ROOM;

typedef struct _tagROOM_NEEDSIGNUP{
 	int nRoomID;
	int nURLLen;
   	int nReserved[4];
  	T_TCHAR szSignUpURL[MAX_URL_LEN];
}ROOM_NEEDSIGNUP, *LPROOM_NEEDSIGNUP;


typedef struct _tagLEAVE_ROOM{
	int nUserID;
	int nAreaID;
	int nGameID;
	int nRoomID;
	T_TCHAR szHardID[MAX_HARDID_LEN];
	int nReserved[4];
}LEAVE_ROOM, *LPLEAVE_ROOM;


typedef struct _tagGET_NEWTABLE{
	int nUserID;								 
	int nRoomID;								 
	int nAreaID;							 
	int nGameID;
	int nTableNO;
	int nChairNO;
   	int nIPConfig;
	int nBreakReq;
	int nSpeedReq;
	int nMinScore;
	int nMinDeposit;
	int nWaitSeconds;
	int nNetDelay;
	T_DWORD dwGetFlags;
  	int nReserved[4];
}GET_NEWTABLE, *LPGET_NEWTABLE;


typedef struct _tagNTF_GET_NEWTABLE{
	PLAYER_POSITION  pp; 
 	int nMinScore;
	int nMinDeposit;
	int nFirstSeatedPlayer;
	int nReserved[4];
}NTF_GET_NEWTABLE, *LPNTF_GET_NEWTABLE;

typedef struct _tagGET_FINISHED{
	int nUserID;								// 用户ID
	int nRoomID;								// 房间ID
	int nAreaID;								// 服务器ID
	int nGameID;								// 游戏ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	T_TCHAR szHardID[MAX_HARDID_LEN];				// 硬件标识符（网卡序列号）
	T_DWORD dwGetFlag;
	int nReserved[3];
}GET_FINISHED, *LPGET_FINISHED;

typedef struct _tagGET_FINISHED_OK{
	int nUserID;								// 用户ID
	int nTableNO;								// 桌号
	int nChairNO;								// 位置
	int nPlayerCount;
	int nPlayerAry[MAX_CHAIR_COUNT];			// 每张椅子对应的新玩家
}GET_FINISHED_OK, *LPGET_FINISHED_OK;



typedef struct _tagQUICK_REG{
	int   nAgentGroupID;		            	// 组编号
	int   nGameID;
 	int   nRecommenderID;
 	T_DWORD dwIPAddr;                              //IP地址
	T_DWORD dwFlags;
  	char  szUsername[MAX_USERNAME_LEN];			// 用户名
    char  szPassword[MAX_PASSWORD_LEN];			// 口令
	char  szWifiID[MAX_HARDID_LEN];			 // wifi网卡,hardid
	char  szSystemID[MAX_HARDID_LEN];	     // 系统ID,volumeid
 	char  szImeiID[MAX_HARDID_LEN];           // imei,15位数字,machineid
	int   nVerifyReturn;
  	int   nReserved[8];
}QUICK_REG, *LPQUICK_REG;

typedef struct _tagQUICK_REG_OK{
  	char  szUsername[MAX_USERNAME_LEN];			// 用户名
    char  szPassword[MAX_PASSWORD_LEN];			// 口令
 	int   nReserved[8];
}QUICK_REG_OK, *LPQUICK_REG_OK;


typedef struct _tagREG_NICKINFO{
	int  nUserID;								// 用户ID
	char szNickName[MAX_NICKNAME_LEN];			// 昵称
	int nNickSex;								// 虚拟性别 0: 男性; 1: 女性
	char szHardID[MAX_HARDID_LEN];	
	T_DWORD dwIPAddr;            
 	int nReserved[3];
}REG_NICKINFO, *LPREG_NICKINFO;



typedef struct _tagPLAYER_EXTEND{
	int   nUserID;
	int   nBirthday;
 	int   nExpiration;							// 账户到期时间
	int   nPlayRoom;							// 比赛房间
	int   nRegFrom;
	int   nHaveBind;
   	int   nLogonSvrID;
	int   nHallBuildNO;
	int   nAgentGroupID;                        // 当前登陆的大厅组
 	int   nDownloadGroup;				    	// 所属下载组
	int   nHallRunCount;
	int   nHallNetDelay;
	int   nOnRegMachine;
  	int   nEnterTime;   						//进入房间时间,2038秒
	int   nStartupTime;                         //开启客户端时间,2038秒
 	int   nEnterGameOKTime;                     //2038秒
 	int   nRandomTableNO;
	int   nRandomChairNO;
	T_LONG  lTokenID;
   	T_TCHAR szHardID[MAX_HARDID_LEN];				// 硬件标识符（网卡序列号）
	T_TCHAR szVolumeID[MAX_HARDID_LEN];	 
 	T_TCHAR szMachineID[MAX_HARDID_LEN];          // 客户端机器唯一标识 
 	T_TCHAR szUniqueID[MAX_UNIQUEID_LEN];			// 
	T_TCHAR szPhysAddr[MAX_PHYSADDR_LEN];
	T_DWORD dwPulseTime;							// tickcount 脉搏信号发送时间
	T_DWORD dwLatestTime;                         // tickcount 最后一个请求发送时间
 	T_DWORD dwLatestStartTime;				  	//  tickcount
 	T_DWORD dwIPAddr;								// IP地址
 	T_DWORD dwSysVer;                             // 客户端操作系统版本
 	T_DWORD dwScreenXY;
	T_DWORD dwEnterFlags;                         // 玩家进入房间的标志
   	T_DWORD dwClientPort;  //存放了客户端和服务端分别取到的2个客户端端口unsigned  short 
	T_DWORD dwServerPort;  //存放了客户端和服务端分别取到的2个服务端端口unsigned  short 
	T_DWORD dwClientSockIP;
	T_DWORD dwRemoteSockIP;
	T_DWORD dwClientLANIP;//本地局域网地址
	T_DWORD dwClientMask;
	T_DWORD dwClientGateway;
	T_DWORD dwClientDNS;
	T_DWORD dwPwdCode;
 	T_DWORD dwPixelsXY;
	T_DWORD dwClientFlags;
	int   nDuan;
	int   nDuanScore;
	int   nRank;
	T_BOOL  bRealPlaying;//真正在玩。
	int   nGiftDeposit;//本次进房间获赠银子
	int	  nQuanID;
  	int   nReserved[1];
}PLAYER_EXTEND,*LPPLAYER_EXTEND;
 

typedef struct _tagPLAYER{
	int nUserID;								// 用户ID
	int nUserType;								// 用户类型
	int nStatus;								// 玩家状态
  	int nTableNO;								// 桌号
	int nChairNO;								// 位置
 	int nNickSex;								// 显示性别 -1: 未知; 0: 男性; 1: 女性
	int nPortrait;								// 头像
 	int nNetSpeed;								// 网速
	int nClothingID;							// 服装ID
	T_TCHAR szUsername[MAX_USERNAME_LEN];			// 用户名
	T_TCHAR szNickName[MAX_NICKNAME_LEN];			// 绰号
	int	nDeposit;								// 银子
	int nPlayerLevel;							// 级别
	int nScore;									// 积分
	int nBreakOff;								// 断线
	int nWin;									// 赢
	int nLoss;									// 输
	int nStandOff;								// 和
	int nBout;									// 回合
	int nTimeCost;								// 花时
	int nGrowthLevel;							// 帐号成长等级
	int nMemberLevel;							// 会员等级
    PLAYER_EXTEND pe;
}PLAYER, *LPPLAYER;

typedef struct _tagENTER_ROOM_OK{
	int nPlayerCount;							// 玩家个数
	int nTableCount;                            //总桌子个数
	int nActiveTableCount;				    	// 活动桌子数
	int nRoomTokenID;                          //房间令牌,每位玩家有唯一的房间令牌
	T_DWORD dwEnterOKFlag;                       //返回信息标志 
    int nRoomPulseInterval;                     //秒
	T_DWORD dwClientIP;
	int nGiftDeposit;						   //本次进房间获赠银两
  	int nReserved[2]; 
}ENTER_ROOM_OK, *LPENTER_ROOM_OK;

typedef struct {
	ENTER_ROOM_OK	enterRoomInfo;
	PLAYER			playerInfo;
} EnterRoomCompletion;

typedef struct _tagQUERY_WEALTH{
	int nUserID;								//查询该玩家通宝
	T_TCHAR szHardID[MAX_HARDID_LEN];	
	T_DWORD dwIPAddr;
	T_DWORD dwSoapFlags;
	double dSoapReturn;							//通宝值 decimal类型
	int nReserved[8];
}QUERY_WEALTH, *LPQUERY_WEALTH;

typedef struct _tagUSER_WEALTH{
	int nUserID;
	double dWealth;								//通宝值 decimal类型
	int nExchangeRatio;							//兑换比率
	int nReserved[8];
}USER_WEALTH, *LPUSER_WEALTH;

typedef struct _tagEXCHANGE_WEALTH{
	int nUserID;
	T_TCHAR szHardID[MAX_HARDID_LEN];	
	T_DWORD dwIPAddr;
	double dExchangeWealth;						//用来兑换的通宝
	T_DWORD dwSoapFlags;
	int nSoapReturn;
	int nReserved[8];
}EXCHANGE_WEALTH, *LPEXCHANGE_WEALTH;

typedef struct _tagEXCHANGE_WEALTH_OK{
	int nUserID;
	double dExchangeWealth;						//用来兑换的通宝
	int nExchangeDeposit;						//兑换得的银两
	int nReserved[8];
}EXCHANGE_WEALTH_OK, *LPEXCHANGE_WEALTH_OK;

typedef struct _tagHTTP_GET_REQUEST{
	int nUserID;
	T_DWORD dwGetFlags;
	T_TCHAR szHardID[MAX_HARDID_LEN];	
	int   nUrlLength;
	int	  nReserved[8];
	T_TCHAR szURL[MAX_URL_LEN_EX];
}HTTP_GET_REQUEST, *LPHTTP_GET_REQUEST;

typedef struct _tagMODIFY_USERNAME{
	int		nAgentGroupID;
	int		nGameID;
	int		nUserID;								// 用户ID
	T_TCHAR	szOldName[MAX_USERNAME_LEN];			// 老名字
	T_TCHAR	szNewName[MAX_USERNAME_LEN];			// 新名字
	T_TCHAR	szHardID[MAX_HARDID_LEN];	
	T_TCHAR	szRndKey[MAX_RNDKEY_LEN_EX];
	T_DWORD	dwIPAddr;    
	int		nKeyResult;
	int		nReserved[4];
}MODIFY_USERNAME, *LPMODIFY_USERNAME;

typedef struct _tagBACK_DEPOSIT{
	int nUserID;
	int nBackDeposit;				//后备箱银子
	int nReserved[4];
}BACK_DEPOSIT, *LPBACK_DEPOSIT;

typedef QUERY_SAFE_DEPOSIT   QUERY_BACKDEPOSIT;
typedef LPQUERY_SAFE_DEPOSIT LPQUERY_BACKDEPOSIT;

typedef MOVE_SAFE_DEPOSIT   TAKE_BACKDEPOSIT;
typedef LPMOVE_SAFE_DEPOSIT LPTAKE_BACKDEPOSIT;

typedef TRANSFER_DEPOSIT   TRANSFER_BACKDEPOSIT;
typedef LPTRANSFER_DEPOSIT LPTRANSFER_BACKDEPOSIT;

typedef MOVE_SAFE_DEPOSIT   MOVE_SAFEDEPOSIT_TOBACK;
typedef LPMOVE_SAFE_DEPOSIT LPMOVE_SAFEDEPOSIT_TOBACK;

typedef struct _tagASK_ENTERGAME{
	int nUserID;								 
	int nRoomID;								 
	int nGameID;
	int nTableNO;
	int nChairNO;
	int nNetDelay;
	int nMinScore;
	int nMinDeposit;
   	int nReserved[8];
}ASK_ENTERGAME, *LPASK_ENTERGAME;

typedef struct _tagCLOAKING_DETAIL{
	int  nRoomID;
	int  nGameID;
	char szLeftURL[MAX_URL_LEN];
	char szRightURL[MAX_URL_LEN];
	char szReservedURL[MAX_URL_LEN];
	int  nRightWidth;
	int  nRightHeight;
	int  nPlayerCount;
	int  nCurrentSeconds;
	int  nReserved[7];
}CLOAKING_DETAIL, *LPCLOAKING_DETAIL;

//根据flag更新用户指定信息，有网站更换服装、使用会员道具后触发
typedef struct _tagUPDATE_USERSPECIFYINFO{
	int  nUserID;
	T_TCHAR szHardID[MAX_HARDID_LEN];				// 硬件标识符（网卡序列号）
	T_DWORD dwIPAddr;
	T_DWORD dwFlag;							
   	int nReserved[8];
}UPDATE_USERSPECIFYINFO, *LPUPDATE_USERSPECIFYINFO;

typedef struct _tagUPDATE_USERSPECIFYINFO_OK{
	int  nUserID;
	T_DWORD dwFlag;
	int  nClothingID;
	int  nMember;
   	int  nReserved[8];
}UPDATE_USERSPECIFYINFO_OK, *LPUPDATE_USERSPECIFYINFO_OK;

typedef struct _tagREFRESH_MEMBER{
	int nUserID;								// 呼叫者ID
	int nRoomID;								// 房间ID
	int nMemberType;					 
	T_TCHAR szHardID[MAX_HARDID_LEN];				// 硬件标识符（网卡序列号）
	int nReserved[4];
}REFRESH_MEMBER, *LPREFRESH_MEMBER;

typedef struct _tagQUERY_MEMBER{
	int nUserID;
	T_TCHAR szHardID[MAX_HARDID_LEN];	
	T_DWORD dwIPAddr;
	int nReserved[4];
}QUERY_MEMBER, *LPQUERY_MEMBER;

typedef struct _tagMEMBER_INFO{
	int nUserID;
	int nMemberType;			// 会员类型
	int nMemberAdds;			// 会员充值次数
	int nMemberBegin;			// 会员开始日期
	int nMemberEnd;				// 会员结束日期
	int nMemberLevel;			// 会员等级
	int nReserved[3];
}MEMBER_INFO,*LPMEMBER_INFO;

typedef TAKE_SALARY_DEPOSIT   TAKE_SALARYDEPOSIT_TOBACK;
typedef LPTAKE_SALARY_DEPOSIT LPTAKE_SALARYDEPOSIT_TOBACK;

typedef struct _tagGET_GAMEVERISON{
	int nUserID;								// 用户ID
	int nGameID;								// 游戏ID
	int nRoomID;								// 房间ID
	T_DWORD dwGetFlags;           
   	int   nReserved[16];
}GET_GAMEVERISON, *LPGET_GAMEVERISON;

typedef struct _tagGET_GAMEVERISON_OK{
	int nGameID;
	int nMajorVer;								// 主版本号
	int nMinorVer;								// 子版本号
	int nBuildNO;								// 生成日期
   	int nReserved[8];
}GET_GAMEVERISON_OK, *LPGET_GAMEVERISON_OK;

typedef enum 
{
	PAY_TO_COFFER = 0,					//充值到保险箱
	PAY_TO_BACK,						//充值到后备箱
	PAY_TO_GAME,						//充值到游戏
} TCY_PAY_TO;

typedef enum 
{
	PAY_FOR_DEPOSIT = 0,				//充值成银子
	PAY_FOR_SCORE,						//充值成积分
	PAY_FOR_TONGBAO,					//充值成通宝
	PAY_FOR_GAMECOIN,					//充值成游戏自定义货币
} TCY_PAY_FOR;

typedef struct _tagPAY_RESULT{
	int				nUserID;
	TCY_PAY_TO		nPayTo;					
	TCY_PAY_FOR		nPayFor;				
	int				nGameID;
	// #ifdef __SUPPORT_LONG_LONG__
	// 	LONGLONG		llOperationID;			//操作ID
	// 	LONGLONG		llBalance;				//余额
	// #else
	long long		llOperationID;			
	long long		llBalance;			
	//#endif
	int				nOperateAmount;			//操作数量
	int				nCreateTime;
	T_DWORD			dwFlags;
	int				nRoomID;
	int				nReserved[16];
}PAY_RESULT, *LPPAY_RESULT;

typedef struct _tagVIP_MEMBERLEVELUP{
	int	  nUserID;
	int   nMemberLevel;				//会员等级
	int   nMemberExp;				//会员经验
	int	  nMemberEnd;				//会员到期时间
	int   nCreateTime;
	T_TCHAR szUrl[MAX_MSMQ_URL_LEN];	//
	int   nReserved[8];
}VIP_MEMBERLEVELUP, *LPVIP_MEMBERLEVELUP;

typedef struct _tagASSIST_SERVER{
	int nID;
	int nGameID;
	int nType;
	int nSubType;
	int nStatus;
   	T_DWORD dwOptions;
	int nPort;
	T_TCHAR szIP[MAX_SERVERIP_LEN];

    int nReserved[16];
}ASSIST_SERVER, *LPASSIST_SERVER;

typedef struct _tagGET_ASSISTSVR{
 	int nGameID;
	int nType;
	int nSubType;
	int nAgentGroupID;
	T_DWORD dwGetFlags;
	T_TCHAR szBaseName[MAX_BASENAME_LEN];

	int nReserved[4];
}GET_ASSISTSVR, *LPGET_ASSISTSVR;

]]