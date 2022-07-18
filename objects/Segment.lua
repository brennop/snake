Segment = Object:extend()

function Segment:new(self, world, x, y, size, speed)
  self.world = world
  self.finalSize = size or 20
  self.speed = speed or 10

  self.body = love.physics.newBody(world, x, y, "dynamic")

  self.body:setLinearDamping(5)
  self.body:setAngularDamping(10)

  self.modX, self.modY = getModular(self.body)

  self.timer = Timer()
  self.size = 0
  self.timer:tween(0.5, self, {size = self.finalSize}, 'in-out-cubic')

  self.shader = love.graphics.newShader('shaders/square.frag')
  self.canvas = love.graphics.newCanvas()
end

function Segment:update(self, dt)
  self.modX, self.modY = getModular(self.body)
  if self.tail then self.tail:update(dt) end
  self.timer:update(dt)
  self.body:applyLinearImpulse(math.sin(self.body:getAngle()) * self.speed, -math.cos(self.body:getAngle()) * self.speed);
end

function Segment:draw()
  love.graphics.setShader(self.shader);
  self.shader:send('pos', {self.modX, self.modY})
  self.shader:send('resolution', {gw, gh})
  self.shader:send('size', {self.size, self.size})
  self.shader:send('rotation', self.body:getAngle())
  love.graphics.draw(self.canvas)
  love.graphics.setShader();
  

  if self.tail then self.tail:draw() end
end

function Segment:drawDebug()
  love.graphics.push()
	love.graphics.translate(self.modX, self.modY)
	love.graphics.rotate(self.body:getAngle())
  love.graphics.rectangle("fill", -self.size / 2, -self.size/ 2, self.size, self.size, 2, 2)
  love.graphics.pop()
end

function Segment:connect(obj)
  self.next = obj
end

function getModular(body)
  return body:getX() % gw, body:getY() % gh
end

function Segment:getModPos()
  return self.modX, self.modY
end

function Segment:addTail(tails)
  self.timer:tween(0.1, self, {size = self.size * 1.25}, 'in-quad', function() 
    self.timer:tween(0.15, self, {size = self.size / 1.25}, 'in-quad') 
    if self.tail then
      self.tail:addTail(tails)
    else
      self.tail = Tail(self.world, self, 12, self.finalSize, self.speed)
      table.insert(tails, self.tail)

      -- make score grow effect
      self.timer:tween(0.15, _G, {scoreScale = 1.15}, 'in-quad', function() 
        self.timer:tween(0.2, _G, {scoreScale = 1}, 'in-quad')
      end)
    end
  end)
end
