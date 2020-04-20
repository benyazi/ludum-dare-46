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
  if #items > 0 then
    local robot = items[1]
    if robot.onCaring then 
      e.exitWithChildEvent = true
    else
      e.exitWithoutChildEvent = true
    end 
    World:notifyChange(e)
  end  
end

return system
