Object = require "lib/classic"
Input = require "lib/Input"

require 'objects/Segment'
require 'objects/Player'
require 'objects/Tail'

function love.load(arg)
  world = love.physics.newWorld(0, 0, true);

  input = Input()
  input:bind('left', 'left')
  input:bind('right', 'right')
  input:bind('up', 'up')

  player = Player(world, love.graphics.getWidth()/2, love.graphics:getHeight()/2, 10, 3)
  tail = Tail(world, player, 24)
end

function love.update(dt)
  player:update(dt)
  tail:update(dt)
  world:update(dt)
end

function love.draw()
  player:draw()
  tail:draw()
end
