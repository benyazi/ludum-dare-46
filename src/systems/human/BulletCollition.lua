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
  local items, len = World.physics:queryPoint(e.position.x, e.position.y, damageFilter)
  local touched = false
  for k,v in pairs(items) do
    -- print(Inspect(v))
    -- if v.health then 
      -- local dmg = e.bullet.damage
      -- if v.shield and v.shield > 0 then 
      --   if v.shield >= dmg then 
      --     v.shield = v.shield - dmg
      --   else 
      --     dmg = dmg - v.shield
      --     v.shield = 0
      --   end
      -- end
      -- v.health = v.health - dmg
      touched = true
      -- World:notifyChange(v)
    -- end
  end
  if touched then 
    World:removeEntity(e)
    e = nil
  end
end

return system
