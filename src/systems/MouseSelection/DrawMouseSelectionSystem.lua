local system = Tiny.processingSystem({
  filter = Tiny.filter('mouseSelectPosition'),
  isDrawSystem = true})

function system:process(e)
  local x,y = e.mouseSelectPosition.cameraX, e.mouseSelectPosition.cameraY
  local width, height = e.mouseSelectPosition.endWorldX-e.mouseSelectPosition.worldX,e.mouseSelectPosition.endWorldY-e.mouseSelectPosition.worldY
  love.graphics.setColor(1, 0, 0, 0.5)
  love.graphics.rectangle('line', x, y, width, height)
  love.graphics.setColor(1, 1, 1, 1)
end

return system
