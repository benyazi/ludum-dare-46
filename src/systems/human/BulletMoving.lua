local system = Tiny.processingSystem({
  filter = Tiny.filter('bullet&position')})

function system:onAdd(e)

end

function system:process(e,dt)
  if e.bullet.lifeTimer > 0 then 
    local rad = e.bullet.rad
    local speed = e.bullet.speed
    local x, y = e.position.x, e.position.y
    local x2 = x + math.cos(rad) * speed*dt
    local y2 = y + math.sin(rad) * speed*dt
    e.position.x, e.position.y = x2,y2
    e.bullet.lifeTimer = e.bullet.lifeTimer - dt
    World:notifyChange(e)
  else 
    World:removeEntity(e)
    e = nil
  end
end

return system
