Tail = Segment:extend()

function Tail:new(world, con)
  Tail.super:new(self, world, con.body:getX(), con.body:getY() + 30)

  self.joint = love.physics.newRevoluteJoint(con.body, self.body, self.body:getX(), self.body:getY() - 15, false)
end

function Tail:update(dt)
  self.body:setAngularVelocity(-self.joint:getJointAngle() * 2)
end
