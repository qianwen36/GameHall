local target = cc.load('form').build('RoomSpace')

function target:build( MainScene )
	self:message(':build( MainScene )', 'required')
end

function target:showContent( container )
	self:message(':showContent( container )')
end

return target