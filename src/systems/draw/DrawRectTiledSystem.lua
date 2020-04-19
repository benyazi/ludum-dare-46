local system = Tiny.processingSystem({
  filter = Tiny.filter('drawRectTiled&position&size'),
  isDrawSystem = true})

function system:process(e)
  local x,y = e.position.x,e.position.y
  local imgH, imgW = e.drawRectTiled.tileH, e.drawRectTiled.tileW
  -- print(Inspect(e.drawRectTiled))
  love.graphics.setColor(1,1,1)
  for i=1,e.drawRectTiled.wc do
    for j=1,e.drawRectTiled.hc do
      local pox, poy = x + ((i-1) * imgW), y + ((j-1) * imgH)
      love.graphics.draw(e.drawRectTiled.tile, pox, poy)
    end
  end
  love.graphics.setColor(1,1,1)
end

return system
