local system = Tiny.processingSystem({
  filter = Tiny.filter('lootBox')})

function system:onAdd(e)

end

local playerFilter = function(item)
  if item.canLoot then
    return 'touch'
  end
  -- else return nil
end

function system:process(e,dt)
  local active = false
  local changed = false
  local items, len = World.physics:queryRect(e.position.x, e.position.y, 16,16, playerFilter)
  for k,v in pairs(items) do
    active = true
    changed = true
    e.lootBox.target = v
    e.lootBox.active = true    
  end
  if active == false and e.lootBox.active == true then 
    e.lootBox.target = nil
    e.lootBox.active = false
    changed = true
  end
  if changed then 
    -- if active then 
    -- print('CHANGE TRUE')
    -- else 
    --   print('CHANGE FALSE')
    -- end
    World:notifyChange(e)
  end
end

return system
