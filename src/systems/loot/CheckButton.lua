local system = Tiny.processingSystem({
  filter = Tiny.filter('lootBox&hadleInput')})

function system:onAdd(e)

end

function system:process(e,dt)
  if e.lootBox.active ~= true 
    or (e.hadleInput.useAction and e.hadleInput.useAction.isDown == false) 
    or (e.hadleInput.useAction and e.hadleInput.useAction.used) then 
    return
  end
  e.hadleInput.useAction.used = true
  if e.isBox then 
    e.lootBoxOpenEvent = true
  else
    e.lootObjectEvent = true
  end
  World:notifyChange(e)
end

return system
