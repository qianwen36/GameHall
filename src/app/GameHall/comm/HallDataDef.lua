require('ffi').cdef[[
typedef unsigned int T_DWORD;
typedef unsigned int T_UINT;
typedef int T_LONG;
typedef char T_TCHAR;

typedef struct _tagVERSION_MB{          //此结构必须固定长度,应对版本升级
	int nMajorVer;
	int nMinorVer;
	int nBuildNO;
	int nGameID;
 	char szExeName[32];
	int nReserved[4];
}VERSION_MB, *LPVERSION_MB;

typedef struct _tagCHECK_VERSION_OK_MB{       //此结构必须固定长度,应对版本升级
	int nMajorVer;
	int nMinorVer;
	int nBuildNO;
	int nCheckReturn;               
	char szDLFile[64];      //需要下载的安装包文件名(包括后缀)
	char szUpdateWWW[64];
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
	T_TCHAR szServerName[32];
	T_TCHAR szServerIP[32];
	T_TCHAR szWWW[64];
	T_TCHAR szWWW2[64];
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
   	T_TCHAR szAreaName[32];
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
	T_TCHAR szRoomName[32];
	T_TCHAR szGameIP[32];
	T_TCHAR szPassword[32];
	T_TCHAR szWWW[64];
	T_TCHAR szExeName[32];
	T_DWORD dwActivityClothings;	//低位 男生服装， 高位 女生服装
	int nClientID;
	int nReserved[6];
}ROOM, *LPROOM;

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
	T_TCHAR szUsername[32];	
    T_TCHAR szPassword[32];
	T_TCHAR szHardID[32];
	T_TCHAR szVolumeID[32];	 
	T_TCHAR szMachineID[32]; 
    T_TCHAR szHashPwd[32+2];
 	T_TCHAR szRndKey[16];
  	T_DWORD dwSysVer;     
 	int  nLogonSvrID; 
	int  nHallBuildNO;
  	int  nHallNetDelay;	
	int  nHallRunCount;
	int	 nGameID;
	T_DWORD dwGameVer;
	int	 nRecommenderID;
   	int  nReserved[1];
}LOGON_USER, *LPLOGON_USER;

typedef struct _tagLOGOFF_USER{
	int nUserID;
	int nHallSvrID;
	int nAgentGroupID;
	T_DWORD dwIPAddr;
	T_DWORD dwLogoffFlags;
	T_LONG lTokenID;
 	T_TCHAR szHardID[32];
	T_TCHAR szVolumeID[32];
 	T_TCHAR szMachineID[32]; 
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
 	T_TCHAR szNickName[16];
	T_TCHAR szUniqueID[32]; 
	int nMemberLevel;
	int nReserved[3];
}LOGON_SUCCEED, *LPLOGON_SUCCEED;

typedef struct _tagQUERY_USER_GAMEINFO{
	int nUserID;
	int nGameID;
	T_DWORD dwQueryFlags;
 	T_DWORD dwIPAddr;
	char szHardID[32];
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

]]