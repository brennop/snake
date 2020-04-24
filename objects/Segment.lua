vector = require "lib/brinevector"

Segment = Object:extend()

function Segment:new(world, x, y)
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.points = {}
  self.size = 20
end

function Segment:update()
end

function Segment:draw()
  local modX, modY = getModular(self.body)
  local modPoints = {getPoints(modX, modY, self.size/2, self.body:getAngle())}

  for i=1,4 do
    if (modPoints[2*i-1] / love.graphics:getWidth()) > (modX / love.graphics:getWidth()) then
      love.graphics.polygon("fill", getPoints(modX - love.graphics:getWidth(), modY, self.size/2, self.body:getAngle()))
    elseif (modPoints[2*i-1] / love.graphics:getWidth()) < (modX / love.graphics:getWidth()) then
      love.graphics.polygon("fill", getPoints(modX + love.graphics:getWidth(), modY, self.size/2, self.body:getAngle()))
    end
  end

  for i=1,4 do
    if (modPoints[2*i] / love.graphics:getHeight()) > (modX / love.graphics:getHeight()) then
      love.graphics.polygon("fill", getPoints(modX, modY - love.graphics:getHeight(), self.size/2, self.body:getAngle()))
    elseif (modPoints[2*i] / love.graphics:getHeight()) < (modX / love.graphics:getHeight()) then
      love.graphics.polygon("fill", getPoints(modX, modY + love.graphics:getHeight(), self.size/2, self.body:getAngle()))
    end
  end

  love.graphics.polygon("fill", getPoints(modX, modY, self.size/2, self.body:getAngle()))
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

--  love.graphics.rectangle("fill", self.body:getX() - self.size/2, self.body:getY() - self.size/2, self.size, self.size)
-- love.graphics.rectangle("fill", (self.body:getX() - self.size/2) % love.graphics:getWidth(), self.body:getY() - self.size/2, self.size, self.size)
--  love.graphics.rectangle("fill", self.body:getX() - self.size/2, (self.body:getY() - self.size/2) % love.graphics:getHeight(), self.size, self.size)
-- love.graphics.rectangle("fill", (self.body:getX() - self.size/2) % love.graphics:getWidth(), (self.body:getY() - self.size/2) % love.graphics:getHeight(), self.size, self.size)
