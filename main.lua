Object = require "lib/classic"
Input = require "lib/Input"
Vector = require "lib/brinevector"
Timer = require "lib/timer"

require 'objects/Segment'
require 'objects/Player'
require 'objects/Tail'
require 'objects/Food'

local tick = require 'lib/tick'

gw = 384
gh = 216

function love.load(arg)
  love.graphics.setDefaultFilter('nearest')
	tick.rate = (1/60)
  world = love.physics.newWorld(0, 0, true);

  input = Input()
  input:bind('left', 'left')
  input:bind('right', 'right')

  player = Player(world, gw/2, gh/2, 3, 3, 10)
  tails = {player}

  food = Food(3)
  canvas = love.graphics.newCanvas()
end

function love.update(dt)
  player:update(dt)
  world:update(dt)

  local p = Vector(player:getModPos())
  dist = food.pos - p
  if dist.length < 14 then
    food:eat()
    player:addTail(tails)
  end
end

function love.draw()
	love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, 10)
  love.graphics.setCanvas(canvas)
    love.graphics.clear()
    player:draw()
    food:draw()
  love.graphics.setCanvas()

  love.graphics.draw(canvas, 0, 0, 0, 2, 2)
end

