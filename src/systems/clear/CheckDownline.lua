local system = Tiny.processingSystem({
  filter = Tiny.filter('checkDownline&position')
})

function system:process(e)
  if e and e.position.y > DOWNLINE + 300 then 
    if e.isChildren then 
      gameOver('Children died')
    else 
      gameOver('You died')
    end
  end
end

return system
