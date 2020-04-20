local system = Tiny.processingSystem({
  filter = Tiny.filter('lootBox&position'),
  isDrawSystem = true})

function system:process(e)
  if e.lootBox.active ~= true or e.onHands then 
    return
  end
  local scancode = e.hadleInput.useAction.scancode
  -- love.graphics.print('Press ' .. scancode .. ' to catch', e.position.x, e.position.y - 15)
  -- return default color
  love.graphics.setColor(1,1,1)
end

return system
