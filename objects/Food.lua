Food = Object:extend()

local deadzone = 10

function Food:new(size)
  self.size = 4
  self:setRandomPosition()
end

function Food:draw()
  local x, y = self.pos.x % gw, self.pos.y % gh

  for i=-0,0 do
    for j=-0,0 do
      love.graphics.rectangle("fill", x + i * gw, y + j * gh, self.size, self.size, 2, 2)
    end
  end
end

function Food:setRandomPosition()
  self.pos = { 
    x = love.math.random(gw - deadzone) + deadzone / 2,
    y = love.math.random(gh - deadzone) + deadzone / 2
  }
end

function Food:eat()
  self:setRandomPosition()
end

