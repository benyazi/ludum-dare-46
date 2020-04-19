local system = Tiny.processingSystem({
  filter = Tiny.filter('drawSprite&rigibody')
})

function system:process(e)
  local curScaleX = e.drawSprite.scale.x
  local changed = false

  local cameraX,cameraY = love.mouse.getPosition()
  local worldX, worldY = Camera:worldCoords(cameraX,cameraY)
  local checkX = worldX - e.position.x
  e.orientation = -1
  if checkX > 0 then
    e.orientation = 1
  end

  if curScaleX > 0 and checkX < 0 then
    curScaleX = -curScaleX
    e.drawSprite.scale.x = curScaleX
    changed = true
  elseif curScaleX < 0 and checkX > 0 then 
    curScaleX = -curScaleX
    e.drawSprite.scale.x = curScaleX
    changed = true
  end
  if changed then
    World:notifyChange(e)
  end
end

return system
