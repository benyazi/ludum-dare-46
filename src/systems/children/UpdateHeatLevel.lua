local system = Tiny.processingSystem({
  filter = Tiny.filter('isChildren')})

function system:onAdd(e)

end

function system:process(e,dt)
  if e.onPlatform then
    e.heat.current = e.heat.current - e.heat.perframe*dt
    World:notifyChange(e)
  end

  if e.heat.current <= 0 then
    gameOver('children_is_cold')
  end
end

return system
