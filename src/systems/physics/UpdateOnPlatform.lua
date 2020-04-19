local system = Tiny.processingSystem({
  filter = Tiny.filter('rigibody&position')
})


local checkPlatformFilter = function(item)
  if item.isPlatform then
    return 'touch'
  end
  -- else return nil
end

function system:process(e, dt)
  local curX, curY = e.position.x, e.position.y

  local items, len = World.physics:queryRect(
    e.position.x, e.position.y,
    e.size.w, e.size.h+1, checkPlatformFilter)
  if #items > 0 then 
    e.onPlatform = true
  else
    e.onPlatform = nil
  end  
  -- print(Inspect(e.onPlatform))
  World:notifyChange(e)
end

return system
