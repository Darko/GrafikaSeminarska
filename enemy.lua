enemy = {}

enemyConstants = {}
enemyConstants.DEFAULT_SPEED = 2
enemyConstants.DEFAULT_ACCELERATION = 0.05

enemies_ctrl = {}
enemies_ctrl.enemies = {}
enemies_ctrl.images = {}
enemies_ctrl.prize = {}
enemies_ctrl.damage = {}

enemies_ctrl.images[0] = love.graphics.newImage('img/enemy1.png')
enemies_ctrl.images[1] = love.graphics.newImage('img/enemy2.png')
enemies_ctrl.images[2] = love.graphics.newImage('img/enemy3.png')
enemies_ctrl.images[3] = love.graphics.newImage('img/enemy4.png')
enemies_ctrl.images[4] = love.graphics.newImage('img/enemy5.png')

enemies_ctrl.prize[0] = 10
enemies_ctrl.prize[1] = 5
enemies_ctrl.prize[2] = 3
enemies_ctrl.prize[3] = 4
enemies_ctrl.prize[4] = 7

enemies_ctrl.damage[0] = 20
enemies_ctrl.damage[1] = 12
enemies_ctrl.damage[2] = 8
enemies_ctrl.damage[3] = 5
enemies_ctrl.damage[4] = 15

enemies_ctrl.speed = enemyConstants.DEFAULT_SPEED

function enemies_ctrl:spawn(x, y)
  local random = love.math.random(0, 4)
  enemy = {}
  enemy.x = (x or love.math.random(-120, 10))
  enemy.y = (y or love.math.random(40, game.height - 40))
  enemy.image = enemies_ctrl.images[random]
  enemy.width = 30
  enemy.height = 30
  enemy.prize = enemies_ctrl.prize[random]
  enemy.damage = enemies_ctrl.damage[random]
  enemy.speed = enemies_ctrl.speed
  enemy.cooldown = 10
  table.insert(self.enemies, enemy)
end

function enemies_ctrl:die(enemy, index)
  table.remove(enemies_ctrl.enemies, index)
end

function enemies_ctrl:draw(e)
  local size = 1
  if e.image == enemies_ctrl.images[2] then
    size = 0.3
  end
  return love.graphics.draw(e.image, e.x , e.y, 0, size)
end

function enemies_ctrl:move()
  for i, e in ipairs(enemies_ctrl.enemies) do
    -- move enemy
    e.x = e.x + e.speed
    -- if it's off screen, remove it and spawn a new one
    if (e.x > game.width + 10) then
      enemies_ctrl:die(e, i)
      enemies_ctrl:spawn()
    end
  end
end

function enemies_ctrl:moveToStart()
  for _, e in pairs(enemies_ctrl.enemies) do
    e.x = 0
  end
end

function enemies_ctrl:drawEnemies()
  for _, e in pairs(enemies_ctrl.enemies) do
    enemies_ctrl:draw(e)
  end
end

function enemies_ctrl:init(amount)
  for i = 0, (amount or 6) do
    enemies_ctrl:spawn()
  end
end

function enemies_ctrl:destroyAll()
  for i, e in ipairs(enemies_ctrl.enemies) do
    table.remove(enemies_ctrl.enemies, i)
  end
end

function enemies_ctrl:stopMoving()
  for _, e in pairs(enemies_ctrl.enemies) do
    e.x = e.x
  end
end

function enemies_ctrl:setSpeed(speed)
  if speed < 0 then 
    return
  end

  enemies_ctrl.speed = enemies_ctrl.speed + speed

  for _, e in pairs(enemies_ctrl.enemies) do
    e.speed = e.speed + speed
  end
end

function enemies_ctrl:resetSpeed()
  enemies_ctrl.speed = enemyConstants.DEFAULT_SPEED
  for _, e in pairs(enemies_ctrl.enemies) do
    e.speed = enemyConstants.DEFAULT_SPEED
  end
end