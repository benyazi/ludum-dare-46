local system = Tiny.processingSystem({
  filter = Tiny.filter('isChildren&onHands')})

function system:onAdd(e)

end

function system:process(e,dt)
  local robo = e.onHands
  if robo.isHeating and e.heat.current < e.heat.max then 
    e.heat.current = e.heat.current + robo.heating.heatSize*dt
    World:notifyChange(e)
  end
end

return system
