local system = Tiny.processingSystem({
  filter = Tiny.filter('isExit')})

function system:onAdd(e)

end

local checkRobotFilter = function(item)
  if item.isRobot then
    return 'touch'
  end
  -- else return nil
end

function system:process(e,dt)
  local changed = false
  local items, len = World.physics:queryRect(e.position.x+12, e.position.y+12, 8, 8, checkRobotFilter)
  if #items > 0 and items[1].onCaring then 
    e.exitEvent = true
    World:notifyChange(e)
  end  
end

return system
