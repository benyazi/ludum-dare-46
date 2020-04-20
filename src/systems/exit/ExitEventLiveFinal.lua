local system = Tiny.processingSystem({
  filter = Tiny.filter('exitWithoutChildEvent')})

function system:onAdd(e)

end

function system:process(e,dt)
  gameWin('live')
end

return system
