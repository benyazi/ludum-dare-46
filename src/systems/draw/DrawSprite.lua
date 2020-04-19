local system = Tiny.sortedProcessingSystem({
  filter = Tiny.filter('drawSprite&position'),
  isDrawSystem = true})


function system:compare(e1, e2)
  local sum1, sum2 = 0,0
  if e1.drawSprite.level > e2.drawSprite.level then 
    sum1 = sum1 + 100
  elseif e1.drawSprite.level < e2.drawSprite.level then 
    sum2 = sum2 + 100
  end

  if e1.position.y > e2.position.y then 
    sum1 = sum1 + 20
  elseif e1.position.y < e2.position.y then 
    sum2 = sum2 + 20
  end

  if e1.position.x > e2.position.x then 
    sum1 = sum1 + 10
  elseif e1.position.x < e2.position.x then 
    sum2 = sum2 + 10
  end
   
  return sum1 < sum2
end

function system:process(e)
  love.graphics.setColor(1,1,1)
  local scaleX, scaleY = 1,1
  local posX, posY = e.position.x, e.position.y
  if e.drawSprite.scale then
    scaleX, scaleY = e.drawSprite.scale.x, e.drawSprite.scale.y
    if scaleX < 0 then 
      posX = posX + e.drawSprite.sprite:getWidth()
    end
  end
  if e.drawSprite.animation then 
    e.drawSprite.animation:draw(e.drawSprite.sprite, posX, posY, nil, scaleX, scaleY)
  else
    love.graphics.draw(e.drawSprite.sprite, posX, posY, nil, scaleX, scaleY)
  end
  -- return default color
  love.graphics.setColor(1,1,1)
end

return system
