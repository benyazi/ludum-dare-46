local system = Tiny.processingSystem({
  filter = Tiny.filter('drawFps'),
  isDrawGuiSystem = true})

function system:process(e)
	love.graphics.setColor(1,0,0)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 5, 5)
	love.graphics.setColor(1,1,1)
end

return system
