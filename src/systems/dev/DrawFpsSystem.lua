local system = Tiny.processingSystem({
  filter = Tiny.filter('drawFps'),
  isDrawGuiSystem = true})

function system:process(e)
	love.graphics.setColor(1,0,0)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 5, 5)
  if DEV then 
  love.graphics.print("DEV: on", 5, 25)
  end
	love.graphics.setColor(1,1,1)
end

return system
