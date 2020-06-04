Game = Object:extend()

function Game:new()
  world = love.physics.newWorld(0, 0, true);

  player = Player(world, gw/2, gh/2, 3, 3, 10)
  tails = {player}

  food = Food(3)
end

function Game:update(dt)
  player:update(dt)
  world:update(dt)

  local p = Vector(player:getModPos())
  dist = food.pos - p
  if dist.length < 14 then
    food:eat()
    player:addTail(tails)
  end

  checkCollisions()
end

function Game:draw()
    player:draw()
    food:draw()
end

function checkCollisions()
  local size = player.size

  for index, tail in ipairs(tails) do
    local current = Vector(tail:getModPos())
    
    for i=index+1,#tails-1 do
      local other = Vector(tails[i]:getModPos())

      if (current - other).length < ( size * 0.66 ) then
        love.event.quit()
      end
    end
  end
end
