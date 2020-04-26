Player = Segment:extend()

local horizontalAxis = 0

function Player:new(world, x, y, speed, rotationSpeed)
  Player.super:new(self, world, x, y)
  self.speed = speed or 10
  self.rotationSpeed = rotationSpeed or 4
end

function Player:update(dt)
  Player.super:update(self)
  if input:down('right') then horizontalAxis = 1
	elseif input:down('left') then horizontalAxis = -1
	else horizontalAxis = 0 end

  self.body:applyLinearImpulse(math.sin(self.body:getAngle()) * self.speed, -math.cos(self.body:getAngle()) * self.speed);
  self.body:setAngularVelocity(horizontalAxis * self.rotationSpeed)
end
