Segment = Object:extend()

function Segment:new(world, x, y)
  self.body = love.physics.newBody(world, x, y, "dynamic")
end

function Segment:update()
end

function Segment:draw()
  love.graphics.circle("line", self.body:getX(), self.body:getY(), 10)
end
