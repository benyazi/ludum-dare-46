local system = Tiny.processingSystem({
  filter = Tiny.filter('isHuman')})

function system:onAdd(e)

end

local targetFilter = function(item)
  if item.isRobot or item.isChildren then
    return 'touch'
  end
  -- else return nil
end

function system:process(e,dt)
  local changed = false
  local items, len = World.physics:queryRect(e.position.x+e.size.w/2-400/2, e.position.y, 400, e.size.h*2, targetFilter)
  if #items > 0 then 
    e.shooting = items[1]
  else
    e.shooting = nil
  end
  World:notifyChange(e)  
end

return system
