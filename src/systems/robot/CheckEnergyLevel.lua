local system = Tiny.processingSystem({
  filter = Tiny.filter('energy')})

function system:onAdd(e)

end

function system:process(e,dt)
  if e.energy.current < 0 then 
    gameOver('You dont have energy!')
  end
end

return system
