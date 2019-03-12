require('ffi').cdef[[
typedef unsigned int T_DWORD;
typedef unsigned int T_UINT;
typedef int T_LONG;
typedef char T_TCHAR;
typedef int T_BOOL;

////////////////////////////////////////////////////////
// *Predefine*
typedef enum{
MAX_BASENAME_LEN = 16,
MAX_GAMENAME_LEN =	32,
MAX_TELNO_LEN =		16,
MAX_PASSWORD_LEN =     32,
MAX_HARDID_LEN =       32,
MAX_RNDKEY_LEN_EX =    16,
MAX_USERNAME_LEN =		32,  //最多31个字符;
MAX_AREANAME_LEN =     32,
MAX_ROOMNAME_LEN =     32,
DEF_HASHPWD_LEN =      32,
MAX_UNIQUEID_LEN =     32,
MAX_NICKNAME_LEN =     16,
MAX_PHYSADDR_LEN =     16,
MAX_DLFILENAME_LEN =   64,
MAX_WWW_LEN =			64,
MAX_SERVERNAME_LEN =   32,
MAX_SERVERIP_LEN =     32,
MAX_LEVELINFO_LEN =    360,
MAX_QUERY_ROOMS =     	256,	// 最多查询几个room;
MAX_URL_LEN =          256,
MAX_URL_LEN_EX =       1024,
MAX_WEBSIGN_LEN =      256,
MAX_SYSMSG_LEN =       4096,
MAX_REMARK_LEN =       256,
MAX_CHAIR_COUNT =      8,
DEF_SECUREPWD_LEN =	16,
MIN_SECUREPWD_LEN =	8,
MAX_MSMQ_URL_LEN =		256,
MAX_DESCRIPTION_SIZE =	512,
} Predefine;
]]
