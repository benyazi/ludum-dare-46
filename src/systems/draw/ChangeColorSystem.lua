local system = Tiny.processingSystem({
  filter = Tiny.filter('drawRect'),
  isDrawSystem = true})

function system:process(e)
  if love.keyboard.isDown('w') then
    e.drawRect.color = {
      r=love.math.random(0.1, 0.8),
      g=love.math.random(0.2, 0.95),
      b=love.math.random(0.05, 0.7)
    }
    World:notifyChange(e)
  end
end

function system:preWrap(dt)
end

function system:postWrap(dt)
end

return system
