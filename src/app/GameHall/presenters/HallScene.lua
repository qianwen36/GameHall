local target = cc.load('form').build('HallScene', import('.BasePresenter'))

function target:build( MainScene )
	self.view = MainScene
	
	if self.hall == nil then
		local hall = self:model('BaseHall')
		hall:on(hall.CONNECTION, handler(self, self.onConnected))
		hall:on(hall.MODEL_READY, handler(self, self.onHallReady))
		hall:on(hall.EVENT_EXCEPTION_BREAK, handler(self, self.onCommunicationBreak))
		if hall:state('ready') then
			self:nextSchedule(self.onHallReady)
		end
		self.hall = hall
	end
	self.userProfile = MainScene:presenter('UserProfile'):build(MainScene)
	self.mainPanel = MainScene:presenter('MainPanel'):build(MainScene)
	return self
end

function target:onHallReady()
    -- show content, and start login
    self.userProfile:prepare()
    self.mainPanel:prepare()
end

function target:onConnected( event )
end

function target:onCommunicationBreak( event )
	local value = event.value
	local handler = {
	[self.hall.EVENT_CONNECTION] = function ()
		self.view:showToast('大厅连接失败')
	end;
	}
	handler = handler[value.event]
	return handler and handler()
end

function target:goBack()
	self.mainPanel:goBack()
end

function target:clean()
	self.view = nil
	self.mainPanel:clean()
	self.userProfile:clean()
end

return target