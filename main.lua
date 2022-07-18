Object = require "lib/classic"
Input = require "lib/Input"
Timer = require "lib/timer"
local moonshine = require "lib/moonshine"

require 'objects/Game'
require 'objects/State'
require 'objects/Segment'
require 'objects/Player'
require 'objects/Tail'
require 'objects/Food'

gw = 384
gh = 216

INITIAL_SIZE = 3

scoreScale = 1

function love.load(arg)
  love.graphics.setDefaultFilter('nearest')

  font = love.graphics.newFont('assets/roboto.ttf', 48)

  input = Input()
  input:bind('left', 'left')
  input:bind('a', 'left')
  input:bind('right', 'right')
  input:bind('d', 'right')

  love.graphics.setBackgroundColor(0.1, 0.1, 0.1, 1)
  canvas = love.graphics.newCanvas()

  effect = moonshine(moonshine.effects.glow)
    .chain(moonshine.effects.scanlines)
    .chain(moonshine.effects.crt)
    .chain(moonshine.effects.chromasep)

  effect.glow.strength = 1.2
  effect.scanlines.opacity = 0.2
  effect.chromasep.radius = 1

  gameState = State(Game)
end

function love.update(dt)
  gameState:current():update(dt)
end

function love.draw()
  love.graphics.setCanvas(canvas)
    love.graphics.clear()
      gameState:current():draw()
  love.graphics.setCanvas()

  -- effect(function()
    love.graphics.draw(canvas, 1, 0, 0, 2, 2)
  -- end)
	love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, 10)
end
