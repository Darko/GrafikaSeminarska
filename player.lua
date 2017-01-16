-- player --
missed = 0
score = 0
lives = 3
health = 100

function createPlayer()
  player = {}
  player.image = love.graphics.newImage('img/player.png')
  player.width = 40
  player.height = 60
  player.x = game.width - 20 - player.width
  player.y = (game.height / 2) - (player.height / 2)
  player.bullets = {}
  player.speed = 5
  player.cooldown = 10
  player.fire = function()
    if (player.cooldown <= 0) then
      player.cooldown = 10
      bullet = {}
      bullet.height = 5
      bullet.width = 8
      bullet.x = player.x
      bullet.y = player.y + (player.height / 2) - bullet.height * 2.5
      table.insert(player.bullets, bullet)
    end
  end

  player.draw = function()
    return love.graphics.draw(player.image, player.x , player.y, 0, 0.5)
  end

  player.move = function(direction)
    if (player.y + direction > game.height) then
      player.y = 0
    elseif (player.y + direction < 0) then
      player.y = game.height - player.height
    else
    end
      player.y = player.y + direction
  end

end