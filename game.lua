require "player"
require "enemy"
require "physics"

game = {}
game.width = 800
game.height = 600
game.status = "start"

bgImage = love.graphics.newImage('img/background.png')

-- Methods

game.init = function()
  game.play()

  if game.status == "over" then
    enemies_ctrl:stopMoving()
    physics.collision.setCollision(false)
  end
end

game.start = function()
  if (game.status == "play") then
    return
  else
    enemies_ctrl:move()
    physics.collision.setCollision(true)
    game.status = "play"
    enemies_ctrl:init(5)
  end
end

game.reset = function()
  enemies_ctrl:destroyAll()
  enemies_ctrl:resetSpeed()
  score = 0
  lives = 3
  health = 100
  game.status = "play"
  enemies_ctrl:init(2)
  physics.collision.setCollision(true)
end

game.over = function()
  love.graphics.setColor(255, 255, 255)
  love.graphics.setNewFont(48)
  love.graphics.printf("GAME\nOVER", 0, (game.height / 2) - 250, game.width, "center")

  love.graphics.setNewFont(24)
  love.graphics.printf("Your score: \n" .. score, 0, (game.height / 2), game.width, "center")

  love.graphics.setNewFont(21)
  love.graphics.printf("Press R to restart", 0, (game.height / 2) + 120, game.width, "center")

  enemies_ctrl:stopMoving()
  physics.collision.setCollision(false)
end

game.play = function()
  if (health <= 0) then
    if (lives == 0) then
      health = 0
      game.status = "over"
    else
      lives = lives - 1
      health = 100
    end
  end

  player.cooldown = player.cooldown - 1
  setControls()
  moveBullets()

  if (game.status == "play") then 
    enemies_ctrl:move()
  end

  killEnemyCollision(enemies_ctrl.enemies, player.bullets)
  enemyPlayerCollision(enemies_ctrl.enemies)

  if ( score > 0 and score % 100 == 0) then
    enemies_ctrl:setSpeed(enemyConstants.DEFAULT_ACCELERATION)
  end
end

game.pause = function()
  if (game.status == "pause") then
    game.status = "play"
    enemies_ctrl:move()
    physics.collision.setCollision(true)
  elseif (game.status == "play") then
    game.status = "pause"
    enemies_ctrl:stopMoving()
    physics.collision.setCollision(false)
  else
    return
  end
end

-- Screens

game.startScreen = function()
  love.graphics.setColor(255, 255, 255)
  love.graphics.setNewFont(48)
  love.graphics.printf("DANK MEMES \nMELT STEEL BEAMS", 0, (game.height / 2) - 100, game.width, "center")

  love.graphics.setNewFont(21)
  love.graphics.printf("Press ENTER to start \n\nPress C to see the controls \n\nPress P to pause", 0, (game.height / 2 + 100), game.width, "center")
end

game.controlsScreen = function()
  enemies_ctrl:stopMoving()
  physics.collision.setCollision(false)

  love.graphics.setColor(255, 255, 255)
  love.graphics.setNewFont(18)
  love.graphics.printf("Press W to shoot \n\nUse the Up/Down arrows to move", 0, (game.height / 2 - 100), game.width, "center")
end

game.pauseScreen = function()
  love.graphics.setColor(255, 255, 255)
  love.graphics.setNewFont(48)
  love.graphics.printf("GAME PAUSED", 0, (game.height / 2) - 100, game.width, "center")
  love.graphics.setNewFont(24)
  love.graphics.printf("Press P to continue", 0, (game.height / 2) + 120, game.width, "center")
end

-- screen stuff

game.showStats = function()
  -- score, missed, lives
  love.graphics.setNewFont(12)
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Lives: " .. lives, 10, 10)
  love.graphics.print("Score: " .. score, 120, 10)

  -- health
  love.graphics.setColor(30, 255, 70)
  love.graphics.print(health .. "%", game.width - 150, 10)
  love.graphics.rectangle("fill", game.width - 110, 10, health, 10)
end

function drawBackground(star)
  return love.graphics.draw(bgImage, 0, 0, 0, 1)
end