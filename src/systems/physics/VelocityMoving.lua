local system = Tiny.processingSystem({
  filter = Tiny.filter('rigibody&position&isRobot')
})

function system:process(e, dt)
  local curX, curY = e.position.x, e.position.y
  local curVelocity = e.rigibody.velocity
  local curSpeed = e.rigibody.speed
  local curJump = e.rigibody.jump
  local mass = e.rigibody.mass
  local gravity = GRAVITY
  if e.onCaring then 
    mass = mass + 1.5
    curSpeed = curSpeed - 50
  end
  
  if love.keyboard.isScancodeDown('d') then
		curVelocity.x = curSpeed
	elseif love.keyboard.isScancodeDown('a') then
    curVelocity.x = -curSpeed
  else
    curVelocity.x = 0
  end
  
  if e.onPlatform then
		curVelocity.y = 0
  end
  
  if love.keyboard.isScancodeDown('space') then      
    if curVelocity.y == 0 then
      curVelocity.y = -curJump
    end
  end
  curVelocity.y = curVelocity.y - gravity * dt * mass
  
  -- print('Velocity ' .. curVelocity.x .. ' x ' .. curVelocity.y)
  local pos = Vector(curX, curY) + curVelocity*dt

  local act_x, act_y, cols, len = World.physics:move(
        e, pos.x, pos.y,
        function(me, other)
          if other.isPlatform ~= nil then 
            if other.position.y < e.position.y then 
              curVelocity.y = -curVelocity.y
              return 'bounce' 
            else
              return 'slide' 
            end
          end
    end)
  e.position = {x = act_x, y = act_y}
  -- e.rigibody.velocity = curVelocity
  World:notifyChange(e)
end

return system
