local system = Tiny.processingSystem({
  filter = Tiny.filter('rigibody&!isRobot&!onHands')
})

function system:process(e, dt)
  local curX, curY = e.position.x, e.position.y
  local curVelocity = e.rigibody.velocity
  local gravity = GRAVITY
  if e.onPlatform then 
    curVelocity.y = 0
    e.rigibody.velocity = curVelocity
    World:notifyChange(e)
  else
    curVelocity.y = curVelocity.y - (gravity) * dt * e.rigibody.mass
    local pos = Vector(curX, curY) + curVelocity*dt

    local act_x, act_y, cols, len = World.physics:move(
          e, pos.x, pos.y,
          function(me, other)
            if other.isPlatform ~= nil then 
              return 'slide' 
            end
      end)
    e.position = {x = act_x, y = act_y}
    e.rigibody.velocity = curVelocity
    World:notifyChange(e)
  end
end

return system
