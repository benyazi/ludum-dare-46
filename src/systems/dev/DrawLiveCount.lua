local system = Tiny.processingSystem({
  filter = Tiny.filter('isRobot'),
  isDrawGuiSystem = true})

function system:process(e)
	love.graphics.setColor(1,0.5,0)
  love.graphics.print("Lives: " .. LIVES, 5, WindowHeight - 50)
  if LAST_DIED_REASON then 
  love.graphics.print("Last Died: " .. LAST_DIED_REASON, 5, WindowHeight - 25)
  end
	love.graphics.setColor(1,1,1)
end

return system
