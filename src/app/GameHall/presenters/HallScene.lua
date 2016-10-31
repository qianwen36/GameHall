local target = cc.load('form').build('HallScene', import('.BasePresenter'))

function target:build( MainScene )
	self.target = MainScene
	
	if self.hall == nil then
		local hall = self:model('BaseHall')
		hall:on(hall.handler.CONNECTION, handler(self, self.onConnection))
		hall:on(hall.MODEL_READY, handler(self, self.onHallReady))
		hall:on(hall.EVENT_EXCEPTION_BREAK, handler(self, self.onCommunicationBreak))
		self.hall = hall
	end
--	self.mainPanel = MainScene:presenter('MainPanel'):build(MainScene)
	self.userProfile = MainScene:presenter('UserProfile'):build(MainScene)
	return self
end

function target:onHallReady()
    -- show content, and start login
 --   self.mainPanel:prepare()
    self.userProfile:prepare()
end

function target:onConnection( event )
	local body = event.body
	local handler = {connected = true, error = true}
	function handler.connected( ... )
	end
	function handler.error( ... )
	    self.mainPanel:clear()
	    self.userProfile:clear()
	end
	handler = handler[body.event]
	return handler and handler()
end

function target:onCommunicationBreak( event )
end

function target:goBack()
	self.mainPanel:goBack()
end

function target:onEnter()
	self.mainPanel:onEnter()
end
function target:onExit()
	self.mainPanel:onEnter()
end

return target