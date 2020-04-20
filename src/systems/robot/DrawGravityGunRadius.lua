local system = Tiny.processingSystem({
  filter = Tiny.filter('usingGravityGun&gravityGun&position'),
  isDrawSystem = true})

function system:process(e)  
  love.graphics.setColor(0,1,0)
  love.graphics.circle('line', e.position.x+e.size.w/2, e.position.y+e.size.h/2, e.gravityGun.radius/2)
  -- love.graphics.circle('fill', WindowWidth/2 - 50, 15, percent, 10)
  -- return default color
  love.graphics.setColor(1,1,1)
end

return system
