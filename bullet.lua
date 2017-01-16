function drawBullet(bullet)
  love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.width, bullet.height)
end

function moveBullets()
  for i, b in ipairs(player.bullets) do 
    if (b.x < -10) then -- if it's off screen -> remove bullet
      table.remove(player.bullets, i)
    end
    -- if it's not, just keep moving
    b.x = b.x - 10
  end
end

function drawBullets()
  for _, b in pairs(player.bullets) do
    drawBullet(b)
  end
end

function destroyBullets()
  for i, b in ipairs(player.bullets) do
    table.remove(player.bullets, i)
  end
end