local target = cc.load('form').build('RoomSpace.interface')

function target:build( MainScene )
	self:definition(':build( MainScene )', 'required')
end

function target:showContent()
	self:definition(':showContent( container )')
end

return target