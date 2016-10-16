USING_MCRuntime = false

cc.FileUtils:getInstance():setPopupNotify(false)
if not USING_MCRuntime then
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")
end

require "config"
require "cocos.init"

local function main()
    require("app.MyApp"):create(Controller):run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
