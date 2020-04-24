require 'objects/Segment'

Player = Segment:extend()

local horizontalAxis = 0

function Player:new(world, x, y)
  Player.super:new(world, x, y)
end

function Player:update(dt)
  if input:down('right') then horizontalAxis = 1
	elseif input:down('left') then horizontalAxis = -1
	else horizontalAxis = 0 end

  -- self.body:applyLinearImpulse(math.sin(self.body:getAngle()) * 0.1, -math.cos(self.body:getAngle()) * 0.1);
  if input:down('up') then self.body:applyLinearImpulse(math.sin(self.body:getAngle()), -math.cos(self.body:getAngle())) end
  -- self.body:setX(love.mouse.getX())
  -- self.body:setY(love.mouse.getY())
  self.body:setAngularVelocity(horizontalAxis)
end
