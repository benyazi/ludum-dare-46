local system = Tiny.processingSystem({
  filter = Tiny.filter('isLetterA&position')})

function system:onAdd(e)

end

function system:process(e,dt)
  local x,y = e.position.x, e.position.y
  local x2 = x + math.cos(e.rad) * 50 * dt
  local y2 = y + math.sin(e.rad) * 50 * dt
  e.position.x = x2
  e.position.y = y2
  World:notifyChange(e)
end

return system
