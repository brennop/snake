Object = require "lib/classic"
Input = require "lib/Input"
Vector = require "lib/brinevector"

require 'objects/Segment'
require 'objects/Player'
require 'objects/Tail'

local tick = require 'lib/tick'

function love.load(arg)
  world = love.physics.newWorld(0, 0, true);

  input = Input()
  input:bind('left', 'left')
  input:bind('right', 'right')
  input:bind('up', 'up')

  player = Player(world, love.graphics.getWidth()/2, love.graphics:getHeight()/2, 6, 3)

  food = Vector(love.math.random(love.graphics:getWidth()), love.math.random(love.graphics:getHeight()))
	tick.rate = (1/60)
end

function love.update(dt)
  player:update(dt)
  world:update(dt)

  local p = Vector(player:getModPos())
  dist = food - p
  if dist.length < 14 then
    food = Vector(love.math.random(love.graphics:getWidth()), love.math.random(love.graphics:getHeight()))
    player:addTail()
  end
end

function love.draw()
  player:draw()
  love.graphics.rectangle("fill", food.x, food.y, 6, 6)
end
