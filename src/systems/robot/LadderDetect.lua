local system = Tiny.processingSystem({
  filter = Tiny.filter('isRobot')})

function system:onAdd(e)

end

local ladderFilter = function(item)
  if item.isLadder then
    return 'touch'
  end
  -- else return nil
end

function system:process(e,dt)
  local items, len = World.physics:queryRect(e.position.x+e.size.w/2, e.position.y+e.size.h/2, e.size.w/4, e.size.h/4, ladderFilter)
  local onLadder = nil
  if #items > 0 then 
    onLadder = true
  else 
    onLadder = nil
  end
  if e.onLadder ~= onLadder then 
    e.onLadder = onLadder
    World:notifyChange(e)
  end
end

return system
