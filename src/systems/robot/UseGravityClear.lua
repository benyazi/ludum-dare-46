local system = Tiny.processingSystem({
  filter = Tiny.filter('offGravity')})

function system:onAdd(e)

end

function system:process(e,dt)
  e.offGravity = nil
  World:notifyChange(e)
end

return system
