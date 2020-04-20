local system = Tiny.processingSystem({
  filter = Tiny.filter('isMsg'),
  isDrawGuiSystem = true})

function system:process(e)
  love.graphics.setColor(1,1,1)
  love.graphics.print(e.text, 100, 25 * e.index)
  -- return default color
  love.graphics.setColor(1,1,1)
end

return system
