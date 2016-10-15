local MOBILE_REQ_BASE = 30000	 
local target = {
  SEND_PULSE			=(MOBILE_REQ_BASE + 1)   ;-- 心跳
  CHECK_VERSION		=(MOBILE_REQ_BASE + 2)   ;-- 此请求号必须固定值,应对版本升级

  GET_SERVERS			=(MOBILE_REQ_BASE + 10)  ;-- 此请求号必须固定,应对版本升级
  GET_AREAS			=(MOBILE_REQ_BASE + 11)  ;-- 获取游戏区 
  GET_ROOMS			=(MOBILE_REQ_BASE + 12)  ;-- 获取房间
  GET_DXXWROOM         =(MOBILE_REQ_BASE + 13)  ;-- 获取断线续玩房间信息=(不等回应)
  GET_ROOMUSERS		=(MOBILE_REQ_BASE + 14)  ;-- 获取指定房间在线人数=(不等回应)
  GET_GAMELEVEL		=(MOBILE_REQ_BASE + 15)  ;-- 获取游戏等级=(不等回应)
  GET_ASSISTSVR		=(MOBILE_REQ_BASE + 16)	 ;-- 获取AssistSvr

  LOGON_USER  			=(MOBILE_REQ_BASE + 100) ;-- 用户登陆
  LOGOFF_USER          =(MOBILE_REQ_BASE + 101) ;-- 用户注销

  GET_RNDKEY			=(MOBILE_REQ_BASE + 120) ;-- 获取随机密码
  GET_TEMPWEBSIGN		=(MOBILE_REQ_BASE + 121) ;-- 获取临时票据
  GET_WEBSIGN			=(MOBILE_REQ_BASE + 122) ;-- 获取网页票据

  REG_USER  			=(MOBILE_REQ_BASE + 140) ;-- 注册新用户
  RESET_PASSWORD  		=(MOBILE_REQ_BASE + 141) ;-- 重设密码
  QUICK_REG  			=(MOBILE_REQ_BASE + 142) ;-- 一键注册
  REG_NICKINFO  		=(MOBILE_REQ_BASE + 143) ;-- 修改昵称性别
  MODIFY_USERNAME		=(MOBILE_REQ_BASE + 144) ;-- 移动端修改用户名

  QUERY_USERID  		=(MOBILE_REQ_BASE + 160) ;-- 查询用户名
  QUERY_SAFE_DEPOSIT	=(MOBILE_REQ_BASE + 161) ;-- 查询保险箱
  QUERY_USER_GAMEINFO	=(MOBILE_REQ_BASE + 162) ;-- 查询游戏信息
  QUERY_SALARY_DEPOSIT	=(MOBILE_REQ_BASE + 163) ;-- 查询游戏工资
  QUERY_BACKDEPOSIT	=(MOBILE_REQ_BASE + 164) ;-- 查询游戏后备箱
  QUERY_MEMBER			=(MOBILE_REQ_BASE + 165) ;-- 查询会员状态

  MOVE_SAFE_DEPOSIT	=(MOBILE_REQ_BASE + 180) ;-- 划保险箱银子到游戏
  TRANSFER_DEPOSIT		=(MOBILE_REQ_BASE + 181) ;-- 游戏银子存入保险箱
  TAKE_SALARY_DEPOSIT	=(MOBILE_REQ_BASE + 182) ;-- 领取游戏工资
  TAKE_GIFT_DEPOSIT	=(MOBILE_REQ_BASE + 183) ;-- 领取赠送银子
  TAKE_BACKDEPOSIT		=(MOBILE_REQ_BASE + 184) ;-- 划后备箱银子到游戏
  SAVE_BACKDEPOSIT		=(MOBILE_REQ_BASE + 185) ;-- 游戏银子存入后备箱
  MOVEDEPOSIT_SAFETOBACK =(MOBILE_REQ_BASE + 186);-- 保险箱转入后备箱
  MOVEDEPOSIT_BACKTOSAFE =(MOBILE_REQ_BASE + 187);-- 后备箱转入保险箱
  MOVEDEPOSIT_BACKTOBACK =(MOBILE_REQ_BASE + 188);-- 多个游戏后备箱之间互转
  TAKE_SALARYDEPOSIT_TOBACK =(MOBILE_REQ_BASE + 189);-- 领取游戏工资,并送入后备箱

  QUERY_WEALTH			=(MOBILE_REQ_BASE + 190)	;-- 查询通宝
  EXCHANGE_WEALTH		=(MOBILE_REQ_BASE + 191)	;-- 通宝兑换成银子，存入保险箱=(是否能冲入游戏)

  HTTP_GET				=(MOBILE_REQ_BASE + 200)	;-- 移动端访问Http Get方式请求代理

  UPDATE_SPECIFY_USERINFO =(MOBILE_REQ_BASE + 210)	;-- 根据flag更新用户指定信息，有网站更换服装、使用会员道具后触发

  ENTER_ROOM  			=(MOBILE_REQ_BASE + 500) ;-- 进房间
  LEAVE_ROOM			=(MOBILE_REQ_BASE + 501) ;-- 离开房间
  GET_NEWTABLE			=(MOBILE_REQ_BASE + 520) ;-- 请求一个座位
  ASK_ENTERGAME   	 	=(MOBILE_REQ_BASE + 521) ;-- 要求加入游戏
  REFRESH_MEMBER		=(MOBILE_REQ_BASE + 522) ;-- 刷新会员
  GET_GAMEVERISON		=(MOBILE_REQ_BASE + 523) ;-- 获取游戏版本信息

  GET_FINISHED			=(MOBILE_REQ_BASE + 530) ;-- 结束
}

return target