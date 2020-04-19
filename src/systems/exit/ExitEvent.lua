local system = Tiny.processingSystem({
  filter = Tiny.filter('exitEvent')})

function system:onAdd(e)

end

function system:process(e,dt)
  nextLevel()
end

return system
