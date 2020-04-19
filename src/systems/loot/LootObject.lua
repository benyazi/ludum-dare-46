local system = Tiny.processingSystem({
  filter = Tiny.filter('lootBox&lootObjectEvent')})

function system:onAdd(e)

end

function system:process(e,dt)
  local v = e.lootBox.target
  if e.isChildren then 
    e.onHands = v
    e.lootObjectEvent = nil
    -- World:removeEntity(e)
    -- e = nil 
    v.drawSprite.sprite = Assets.robot_caring
    v.onCaring = true
    World:notifyChange(v)
    World:notifyChange(e)
  end
end

return system
