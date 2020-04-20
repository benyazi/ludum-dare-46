local system = Tiny.processingSystem({
  filter = Tiny.filter('checkDownline&position')
})

function system:process(e)
  if e and e.position.y > DOWNLINE + 300 then 
    gameOver()
  end
end

return system
