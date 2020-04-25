vector = require "lib/brinevector"

Segment = Object:extend()

function Segment:new(self, world, x, y)
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.points = {}
  self.size = 20
  
  self.body:setLinearDamping(2)
  self.body:setAngularDamping(10)
end

function Segment:update()
end

function Segment:draw()
  local modX, modY = getModular(self.body)
  local modPoints = {getPoints(modX, modY, self.size/2, self.body:getAngle())}

  for i=-1,1 do
    for j=-1,1 do
      love.graphics.polygon("fill", getPoints(modX + i * love.graphics:getWidth(), modY + j * love.graphics:getHeight(), self.size/2, self.body:getAngle()))
    end
  end
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
