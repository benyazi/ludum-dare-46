local system = Tiny.processingSystem({
  filter = Tiny.filter('drawRect&position&size'),
  isDrawSystem = true})

function system:process(e)
  love.graphics.setColor(e.drawRect.color.r, e.drawRect.color.g, e.drawRect.color.b)
  love.graphics.rectangle('fill', e.position.x, e.position.y, e.size.w, e.size.h)
  -- return default color
  love.graphics.setColor(0,0,0)
end

return system
