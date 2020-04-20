local system = Tiny.processingSystem({
  filter = Tiny.filter('isRobot&hadleInput&onCaring')})

function system:onAdd(e)

end


function system:process(e,dt)
  if (e.hadleInput.gravityAction and e.hadleInput.gravityAction.isDown == false) then 
    if e.isHeating then 
      e.isHeating = nil
      World:notifyChange(e)
    end
    return
  end
  if e.isHeating == nil then 
    e.isHeating = true
  end
  e.energy.current = e.energy.current - e.heating.energySize*dt
  World:notifyChange(e)
end

return system
