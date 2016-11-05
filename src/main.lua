USING_MCRuntime = true

cc.FileUtils:getInstance():setPopupNotify(false)
if not USING_MCRuntime then
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")
end

require "config"
require "cocos.init"

local function test(path)
	require(path)
end
local function main()
	-- test('app.TcyCommon.test.utils_test')
    require("app.MyApp"):create(Controller):run('LogoScene')
    -- require("app.MyApp"):create(Controller):run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
