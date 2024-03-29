Game = Object:extend()

function getLength(x, y)
  return math.sqrt(x * x + y * y)
end

function Game:new()
  self.world = love.physics.newWorld(0, 0, true);

  self.player = Player(self.world, gw/2, gh/2, 3, 3, 10)
  self.tails = { self.player }

  for i = 2, INITIAL_SIZE do
    self.player:addTail(self.tails)
  end

  self.food = Food(3)
end

function Game:update(dt)
  self.player:update(dt)
  self.world:update(dt)

  local p_x, p_y = self.player:getModPos()
  local dist = getLength(self.food.pos.x - p_x, self.food.pos.y - p_y)
  if dist < 14 then
    self.food:eat()
    self.player:addTail(self.tails)
  end

  self:checkCollisions()
end

function Game:draw()
  -- this looks awful and unoptimized
  -- TODO: make it look awesome
  local score = love.graphics.newText(font, {{1, 1, 1, 0.5}, string.format("%02d", math.max(#self.tails - INITIAL_SIZE, 0))})
  love.graphics.draw(score, gw/2, gh/2, 0, scoreScale, scoreScale, score:getWidth()/2, score:getHeight()/2)

  self.player:draw()
  self.food:draw()
end

function Game:destroy()
  -- there should be a better way for removing
  -- those thing but I don't know a lot of gcing
  -- probably should use Object:release
  for i, g in ipairs(self.tails) do
    table.remove(g, i)
  end
  self.tails = {}
  self.world = nil
  self.player = nil
  self.food = nil
end

function Game:checkCollisions()
  local size = self.player.size

  for index, tail in ipairs(self.tails) do
    local current_x, current_y = tail:getModPos()
    
    for i=index + 1, #self.tails - 1 do
      local other_x, other_y = self.tails[i]:getModPos()

      -- get dist between current and other
      local dist = getLength(current_x - other_x, current_y - other_y)

      if dist < (size * 0.8) then
        gameState:replace(Game)
        return
      end
    end
  end
end
