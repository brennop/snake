Food = Object:extend()

function Food:new(size)
  self.size = size or 3
  self:setRandomPosition()
end

function Food:draw()
  local x, y = self.pos.x % gw, self.pos.y % gh

  for i=-0,0 do
    for j=-0,0 do
      love.graphics.rectangle("fill", x + i * gw, y + j * gh, self.size, self.size)
    end
  end
end

function Food:setRandomPosition()
  self.pos = { x = love.math.random(gw), y = love.math.random(gh) }
end

function Food:eat()
  self:setRandomPosition()
end

