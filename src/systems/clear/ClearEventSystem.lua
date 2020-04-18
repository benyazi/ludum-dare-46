local system = Tiny.processingSystem({
  filter = Tiny.filter('clearEvent')
})

function system:process(e)
  print("Clear entity")
  World:removeEntity(e)
  e = nil
end

return system
