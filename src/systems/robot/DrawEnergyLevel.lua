local system = Tiny.processingSystem({
  filter = Tiny.filter('energy'),
  isDrawGuiSystem = true})

function system:process(e)  
  local max = e.energy.max
  local cur = e.energy.current
  local percent = cur/(max/100) 

  love.graphics.setColor(0,0,1)
  love.graphics.rectangle('line', WindowWidth/2 - 50, 10, 100, 10)
  love.graphics.rectangle('fill', WindowWidth/2 - 50, 10, percent, 10)

  love.graphics.setFont(Font_10)
  love.graphics.setColor(1,1,1)
  love.graphics.print('Energy', WindowWidth/2 - 45, 11)

  love.graphics.print('Heating: ', WindowWidth/2 + 60, 11)
  if e.isHeating then
    love.graphics.setColor(0,1,0)
    love.graphics.print('On', WindowWidth/2 + 100, 11)
  else
    love.graphics.setColor(1,0,0)
    love.graphics.print('Off', WindowWidth/2 + 100, 11)
  end
  love.graphics.setFont(FontDefault)
  -- return default color
  love.graphics.setColor(1,1,1)
end

return system
