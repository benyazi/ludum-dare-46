local system = Tiny.processingSystem({
  filter = Tiny.filter('mouseSelectPosition')})

function system:onAdd(e)

end

function system:process(e)
  local down = love.mouse.isDown(1)
  if down then
    local cameraX,cameraY = love.mouse.getPosition()
    local worldX, worldY = Camera:worldCoords(cameraX,cameraY)
    e.mouseSelectPosition.endCameraX=cameraX
    e.mouseSelectPosition.endCameraY=cameraY
    e.mouseSelectPosition.endWorldX=worldX
    e.mouseSelectPosition.endWorldY=worldY
    World:notifyChange(e)
  else

    World:removeEntity(e)
    e = nil
  end
end

return system
