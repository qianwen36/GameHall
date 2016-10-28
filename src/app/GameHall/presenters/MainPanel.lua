local target = cc.load('form').build('MainPanel', import('.BasePresenter'))

function target:build( MainScene )
	self.view = MainScene
	
	if (self.player == nil) then
		local player = self:model('PlayerModel')
	end

	if (self.ready) then
		self:prepare(MainScene)
	else
		self:prepare()
	end
	return self
end

function target:onCommunicationBreak( event )
--	self.ready = false
end

return target