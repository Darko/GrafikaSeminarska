require "enemy"
require "player"

physics = {}
physics.collision = {}
physics.collision.enabled = true

function killEnemyCollision(enemies, bullets)
  if physics.collision.enabled then
    for i,e in ipairs(enemies) do
      for j,b in ipairs(bullets) do
        if (b.x <= e.x + e.width) and ((b.y < e.y + e.height) and (b.y > e.y)) then
          table.remove(enemies, i)
          table.remove(bullets, j)
          score = score + e.prize
          enemies_ctrl:spawn()
        end
      end
    end
  end
end

function enemyPlayerCollision(enemies)
  if physics.collision.enabled then
    for i,e in ipairs(enemies) do
      if (e.x + e.width >= player.x) and ((e.y < player.y + player.height) and (e.y > player.y)) then
        table.remove(enemies, i)
        health = health - e.damage
        enemies_ctrl:spawn()
      end
    end
  end
end

physics.collision.setCollision = function(state)
  physics.collision.enabled = state
end