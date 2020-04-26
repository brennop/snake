Player = Segment:extend()

local horizontalAxis = 0

function Player:new(world, x, y, speed, rotationSpeed, size)
  Player.super:new(self, world, x, y, size, speed)
  self.rotationSpeed = rotationSpeed or 4
end

function Player:update(dt)
  Player.super:update(self, dt)
  if input:down('right') then horizontalAxis = 1
	elseif input:down('left') then horizontalAxis = -1
	else horizontalAxis = 0 end

  self.body:setAngularVelocity(horizontalAxis * self.rotationSpeed)
end
