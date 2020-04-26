vector = require "lib/brinevector"

Segment = Object:extend()

function Segment:new(self, world, x, y)
  self.world = world
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.points = {}
  self.size = 20

  self.body:setLinearDamping(2)
  self.body:setAngularDamping(10)
  self.modX, self.modY = getModular(self.body)
end

function Segment:update(self)
  self.modX, self.modY = getModular(self.body)
  if self.tail then self.tail:update() end
end

function Segment:draw()
  local modPoints = {getPoints(self.modX, self.modY, self.size/2, self.body:getAngle())}

  for i=-1,1 do
    for j=-1,1 do
      love.graphics.polygon("fill", getPoints(self.modX + i * love.graphics:getWidth(), self.modY + j * love.graphics:getHeight(), self.size/2, self.body:getAngle()))
    end
  end

  if self.tail then self.tail:draw() end

  -- love.graphics.circle("fill", self.modX - math.sin(self.body:getAngle()) * 12, self.modY + math.cos(self.body:getAngle()) * 12, 4)
end

function Segment:connect(obj)
  self.next = obj
end

function getModular(body)
  return body:getX() % love.graphics:getWidth(), body:getY() % love.graphics:getHeight()
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

function Segment:addTail()
  if self.tail then
    self.tail:addTail()

  else
    self.tail = Tail(self.world, self, 24)
  end
end
