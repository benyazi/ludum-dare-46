local system = Tiny.processingSystem({
  filter = Tiny.filter('bullet')})

function system:onAdd(e)

end

local damageFilter = function(item)
  if item.bulletCollide then
    return 'touch'
  end
  -- else return nil
end

function system:process(e,dt)
  if e == nil then 
    return
  end
  local items, len = World.physics:queryPoint(e.position.x, e.position.y, damageFilter)
  local touched = false
  
  for k,v in pairs(items) do
    if v.isChildren then 
      World:removeEntity(e)
      e = nil
      gameOver('Child dead from bullet.')
      return
    elseif v.isRobot then 
      v.energy.current = v.energy.current - e.bullet.damage
      World:notifyChange(v)
    end
    touched = true
  end
  if touched then 
    World:removeEntity(e)
    e = nil
  end
end

return system
