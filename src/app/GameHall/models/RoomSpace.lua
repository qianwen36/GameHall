local target = {}

function target:build( MainScene )
	self.target = MainScene
	local MainScene_onEnter = MainScene.onEnter
	function MainScene:onEnter()
		MainScene_onEnter(self)
	    local param = self:getApp():getConfig('hall')
	    self.param_ = param
	    self:test('area', param.offline.areas)
	end

	function MainScene:getContentView( name, param )
		local path = self.param_[1] or 'src.app.GameHall.views.content'
		local view = require(path..'.'..name):create(self:getApp(), name, param)
		return view
	end

	local wrap2array
	function MainScene:test( test, param )
		if param==nil then return end
		test = test or 'area'
		local function handler( ... )
			local name, array = wrap2array(param)
			for i, item in ipairs(array) do
				self:addItem(name, item)
			end
			return self:showContent(test)
		end
		return handler()
	end
	function wrap2array( param )
		param = clone(param)
		local name = table.remove(param, 1)
		if #param ==0 then
			param = {param}
		end
		return name, param
	end

	function MainScene:showContent( name )
		local handler = {}
		local function alignChildren( container )
			local c = container:getChildrenCount()
			if c <= 4 then
				local size = container:getContentSize()
				local x = 0
				local y = size.height/2
				local d = size.width/(c+1)
				for i=1, c do
					x = x + d
					container:getChildByTag(i):move(x, y)
				end
			end
			return container
		end
		function handler.area()
			alignChildren(self.areasContainer):show()
			return self
		end
		function handler.room(  )
			alignChildren(self.roomsContainer):show()
			return self
		end
		handler = handler[name]
		return handler and handler()
	end

	function MainScene:addItem( name, param )
		local container = {
			AreaView = self.areasContainer,
			RoomView = self.roomsContainer
		}
		container = container[name]
		local count = container:getChildrenCount()
		name = name or 'AreaView'
		local view = self:getContentView(name, param)
			:setTag(count+1)
			:addTo(container)
		local y = container:getContentSize().height/2
		local size = view:getContentSize()
		if count >0 then
			local node = container:getChildByTag(count)
			local pos = cc.p(node:getPositionX(), node:getPositionY() + size.width/2)
			view:move(pos.x, y)
		else
			view:move(size.width/2, y)
		end
		view:addEventListener(self.handler.BUTTON_CLICKED, function ( data )
			self:onItemClicked(data.target, data.type)
		end)
	end

	function MainScene:onItemClicked( view , type)
		local param = view:getData()
		local handler = {}
		function handler.room( ... )
		end
		function handler.area( ... )
			self:switchContent('room')
			self:test('room', param.rooms)
		end
		handler = handler[type]
		return handler and handler()
	end

	function MainScene:switchContent( name )
		local handler = {}
		function handler.room( ... )
			self.areasContainer:hide()
			self.roomsContainer:show()
			self.btnHead:hide()
			self.btnBack:show()
		end
		function handler.area( ... )
			self.btnHead:show()
			self.btnBack:hide()
			self.roomsContainer:hide()
			self.areasContainer:show()
	        self.cleanContainer(self.roomsContainer)
		end
		handler = handler[name]
		return handler and handler()
	end

	function MainScene.cleanContainer(container)
	    for i = 1, container:getChildrenCount() do
	        container:removeChildByTag(i)
	    end
	end
end

function target:goBack(...)
    self.target:switchContent('area')
end


return target
