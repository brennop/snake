Tail = Segment:extend()

function Tail:new(world, con, offset, size)
  self.offsetX = offset * math.sin(con.body:getAngle())
  self.offsetY = offset * math.cos(con.body:getAngle())

  Tail.super:new(self, world, con.body:getX() - self.offsetX, con.body:getY() + self.offsetY, size)

  self.body:setAngle(con.body:getAngle())
  self.joint = love.physics.newRevoluteJoint(con.body, self.body, con.body:getX() - self.offsetX/2, con.body:getY() + self.offsetY/2, false)
end

function Tail:update(dt)
  Tail.super:update(self, dt)
  self.body:setAngularVelocity(-self.joint:getJointAngle() * 5)
end
