local Base = import('.BaseModel')
local target = cc.load('form').build('HallSpread', Base)

function target:init( app )
--	self:super().init(app) -- 只能应用于final target
	Base.init(self, app)
	self.hall = app:model('BaseHall')
	self:clear()
end

function target:prepare()
	self:definition(':prepare()')
end

function target:clear()
	self:definition(':clear()')
end

return target
