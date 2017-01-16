love.graphics.setDefaultFilter('nearest', 'nearest')

require "game"
require "controls"
require "player"
require "enemy"
require "bullet"
require "physics"

function love.load()
  createPlayer()
end

function love.update()
  game.init()
end

function love.draw()
  -- love.graphics.setColor(180, 180, 30, 0)
  drawBackground()

  -- nacrtaj igrac
  love.graphics.setColor(255, 255, 255)
  player.draw()

  -- crtaj metci
  drawBullets()

  -- crtaj protivnici
  enemies_ctrl:drawEnemies()

  -- statistika
  game.showStats()

  if game.status == "start" then
    game.startScreen()
  elseif game.status == "over" then
    game.over()
  elseif game.status == "controls" then
    game.controlsScreen()
  elseif game.status == "pause" then
    game.pauseScreen()
  end
end