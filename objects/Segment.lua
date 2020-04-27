vector = require "lib/brinevector"

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
  self.timer:tween(0.4, self, {size = self.finalSize}, 'in-out-cubic')
end

function Segment:update(self, dt)
  self.modX, self.modY = getModular(self.body)
  if self.tail then self.tail:update(dt) end
  self.timer:update(dt)
  self.body:applyLinearImpulse(math.sin(self.body:getAngle()) * self.speed, -math.cos(self.body:getAngle()) * self.speed);
end

function Segment:draw()
  local modPoints = {getPoints(self.modX, self.modY, self.size/2, self.body:getAngle())}

  for i=0,0 do
    for j=0,0 do
      love.graphics.polygon("fill", getPoints(self.modX + i * gw, self.modY + j * gh, self.size/2, self.body:getAngle()))
    end
  end

  if self.tail then self.tail:draw() end
end

function Segment:connect(obj)
  self.next = obj
end

function getModular(body)
  return body:getX() % gw, body:getY() % gh
end

function getPoints(x, y, s, r)
  a = vector(s, s):rotated(r) + vector(x, y)
  b = vector(s, -s):rotated(r) + vector(x, y)
  c = vector(-s, -s):rotated(r) + vector(x, y)
  d = vector(-s, s):rotated(r) + vector(x, y)
  return a.x, a.y, b.x, b.y, c.x, c.y, d.x, d.y
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
    end
  end)
end
