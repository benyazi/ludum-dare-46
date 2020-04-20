local system = Tiny.processingSystem({
  filter = Tiny.filter('isHuman&shooting')})

function system:onAdd(e)

end

function system:process(e,dt)
  if e == nil then 
    return
  end
  if e.shootingTimer <= 0 then 
    e.shootingTimer = 0.25
    World:notifyChange(e)  
  else  
    e.shootingTimer = e.shootingTimer - 1 * dt
    World:notifyChange(e)
    return
  end
  local curX,curY = e.position.x+e.size.w/2, e.position.y+e.size.h/2
  math.randomseed(os.time())
  local rad = math.atan2(e.shooting.position.y-e.position.y,e.shooting.position.x-e.position.x)
  local radChange = love.math.random(3)/40
  if love.math.random(2) > 1 then 
    radChange = -radChange
  end
  rad = rad + radChange
  -- local rad = math.pi
  local bullet = {
    bullet = {
      damage = 1,
      lifeTimer = 2,
      speed = 500,
      rad = rad
    },
    position = {
      x = curX,
      y = curY
    },
    size = {w=3,h=3},
    drawRect = Components.DrawRect(0.85,0.15,0.15)
  }
  World:addEntity(bullet)
end

return system
