local system = Tiny.processingSystem({
  filter = Tiny.filter('energy')})

function system:onAdd(e)

end

local energyFilter = function(item)
  if item.isEnergy then
    return 'touch'
  end
  -- else return nil
end

function system:process(e,dt)
  local items, len = World.physics:queryRect(e.position.x, e.position.y, e.size.w, e.size.h, energyFilter)
  if #items > 0 and e.energy.current < e.energy.max then 
    local energy = items[1]
    e.energy.current = e.energy.current + energy.energySize*dt
    World:notifyChange(e)
  end
end

return system
