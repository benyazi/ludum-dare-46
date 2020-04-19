local system = Tiny.processingSystem({
  filter = Tiny.filter('isChildren&onHands')})

function system:onAdd(e)

end

function system:process(e,dt)
  local robo = e.onHands
  local curX, curY = robo.position.x, robo.position.y

  if robo.orientation > 0 then 
    curX,curY = curX + robo.size.w - 8, curY
  else
    curX,curY = curX - 8, curY
  end
  e.position.x,e.position.y = curX,curY
  World:notifyChange(e)
end

return system
