local system = Tiny.processingSystem({
  filter = Tiny.filter('isRobot&hadleInput&!onCaring&gravityGun')})

function system:onAdd(e)

end

local targetGravityFilter = function(item)
  if item.isChildren then
    return 'touch'
  end
  -- else return nil
end


function system:process(e,dt)
  if (e.hadleInput.gravityAction and e.hadleInput.gravityAction.isDown == false) then 
    if e.usingGravityGun then 
      e.usingGravityGun = nil
      World:notifyChange(e)
    end
    return
  end
  e.usingGravityGun = true
  local items, len = World.physics:queryRect(e.position.x+e.size.w/2-e.gravityGun.radius/2, e.position.y-e.size.h/2-e.gravityGun.radius/2, e.gravityGun.radius, e.gravityGun.radius, targetGravityFilter)
  if #items > 0 then 
    local child = items[1]
    local rad = math.atan2(child.position.y - e.position.y, child.position.x - e.position.x)
    local x, y = child.position.x, child.position.y
    local x2 = x - math.cos(rad) * e.gravityGun.speed*dt
    local y2 = y - math.sin(rad) * e.gravityGun.speed*dt
    child.position.x, child.position.y = x2,y2
    child.offGravity = true
    World:notifyChange(child)

    e.energy.current = e.energy.current - e.gravityGun.energySize*dt
  else
    print('Not found child')
  end    
  World:notifyChange(e)
end

return system
