local system = Tiny.processingSystem({
  filter = Tiny.filter('heat&position'),
  isDrawSystem = true})

function system:process(e)
  if e.heat.current >= e.heat.max then 
    return
  end
  
  local max = e.heat.max
  local cur = e.heat.current
  local percent = cur/(max/100) 

  love.graphics.setColor(1,0,0)
  love.graphics.rectangle('line', e.position.x, e.position.y - 10, 16, 3)
  love.graphics.rectangle('fill', e.position.x, e.position.y - 10, percent/(100/16), 3)
  -- return default color
  love.graphics.setColor(1,1,1)
end

return system
