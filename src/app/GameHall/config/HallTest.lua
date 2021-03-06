local config = {
	test = 'test',
	user = {name = 'liaoqf02', password = '7890-='},
	abbr = 'erqs',
	--server = '192.168.1.222:31626',
	server = '122.224.230.90:31626',
	target = 'AND',
	version = '2.1.20130822',
	gameid = 568,
	agentGroup = 6,

	-- ui.config
	refresh = {gameinfo = 60, onlineusers = 30},
	display = {level = 2, 'ItemViewEx', 'ItemView2', background = 'two_pandas'}, --[['gelou', 'leitai', 'two_pandas']]
--	display = {level = 1,'ItemViewEx'},
	
	-- offline
	area = {
	id = -1,
	icon = 0,
	online = 0,
	name = 'localhost',
	},--area
	room = {
	id = -1,
	icon = 0,
	online = 0,
	name = '本地测试',
	data = {
	szGameIP = '127.0.0.1',
	nGamePort = 21568,
	nPort = 0,
	nAreaID = 1434,
	nRoomID = 5360,
	nGameVID = 1005680000,
	},-- data
	},-- room
}

return config