local system = Tiny.processingSystem({
  filter = Tiny.filter('dragable')})

local dragByCanDragFilter = function(item)
  if item.canDrag then
    return 'touch'
  end
  -- else return nil
end

function system:process(e)
  local items, len = World.physics:queryPoint(e.position.x, e.position.y, dragByCanDragFilter)
  for k,v in pairs(items) do
    if e.dragWeapon then 
      v.weapon = e.dragWeapon
      World:removeEntity(e)
      e = nil 
      World:notifyChange(v)
    elseif e.dragAmmunition and v.weapon then 
      v.weapon.store = v.weapon.store + e.dragAmmunition.count
      World:removeEntity(e)
      e = nil 
      World:notifyChange(v)
    elseif e.dragPills and v.health then 
      v.health = v.health + e.dragPills.count
      World:removeEntity(e)
      e = nil 
      World:notifyChange(v)
    elseif e.dragGranate then 
      v.granate = e.dragGranate
      World:removeEntity(e)
      e = nil 
      World:notifyChange(v)
    end
  end
end

return system
