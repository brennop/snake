Tail = Segment:extend()

function Tail:new(world, con, offset)
  self.offsetX = offset * math.sin(con.body:getAngle())
  self.offsetY = offset * math.cos(con.body:getAngle())

  Tail.super:new(self, world, con.body:getX() + self.offsetX, con.body:getY() + self.offsetY)

  self.joint = love.physics.newRevoluteJoint(con.body, self.body, self.body:getX(), self.body:getY() - 15, false)
end

function Tail:update(dt)
  self.body:setAngularVelocity(-self.joint:getJointAngle() * 5)
end
