require "player"
require "enemy"
require "game"

function setControls()
  if love.keyboard.isDown("down") then
    player.move(player.speed)
  elseif love.keyboard.isDown("up") then
    player.move(-player.speed)
  elseif love.keyboard.isDown("w") then
    player.fire()
  end
end


function love.keyreleased(key)
  if key == "r" then
    game.reset()
  elseif key == "return" then
    if game.status == "playing" then
      return
    elseif game.status == "over" then
      enemies_ctrl:destroyAll()
      game.reset()
      return
    end
    game.start()
  elseif key == "c" then
    game.status = "controls"
  elseif key == "p" then
    game.pause()
  end
end