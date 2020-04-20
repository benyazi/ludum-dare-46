local system = Tiny.processingSystem({
  filter = Tiny.filter('exitWithChildEvent')})

function system:onAdd(e)

end

function system:process(e,dt)
  gameWin('doom')
end

return system
