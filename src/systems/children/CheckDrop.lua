local system = Tiny.processingSystem({
  filter = Tiny.filter('onHands&hadleInput&!dropChildrenEvent')})

function system:onAdd(e)

end

function system:process(e,dt)
  if (e.hadleInput.dropAction and e.hadleInput.dropAction.isDown == false) 
    or (e.hadleInput.dropAction and e.hadleInput.dropAction.used) then 
    return
  end
  e.hadleInput.dropAction.used = true
  e.dropChildrenEvent = true
  -- e.onCaring = nil
  World:notifyChange(e)
end

return system
