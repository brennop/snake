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

  player = Player(world, love.graphics.getWidth()/2, love.graphics:getHeight()/2, 10, 3)
  tail = Tail(world, player, 24)

  food = Vector(love.math.random(love.graphics:getWidth()), love.math.random(love.graphics:getHeight()))
	tick.rate = (1/60)
end

function love.update(dt)
  player:update(dt)
  tail:update(dt)
  world:update(dt)

  local p = Vector(player.body:getX(), player.body:getY())
  dist = food - p
  if dist.length < 14 then
    food = Vector(love.math.random(love.graphics:getWidth()), love.math.random(love.graphics:getHeight()))
  end
end

function love.draw()
  love.graphics.print(dist.length, 10, 10)
  player:draw()
  tail:draw()
  love.graphics.rectangle("fill", food.x, food.y, 8, 8)
end
