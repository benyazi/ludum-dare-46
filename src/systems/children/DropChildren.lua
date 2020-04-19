local system = Tiny.processingSystem({
  filter = Tiny.filter('dropChildrenEvent&onHands')})

function system:onAdd(e)

end

function system:process(e,dt)
  local robo = e.onHands
  local curX, curY = robo.position.x, robo.position.y

  if robo.orientation > 0 then 
    curX,curY = curX + robo.size.w, curY
  else
    curX,curY = curX - 16, curY
  end
  e.position.x,e.position.y = curX, curY
  -- World:addEntity(Entities.Children(curX, curY, 16, 16))
  e.dropChildrenEvent = nil
  e.onHands = nil
  World:notifyChange(e)
  robo.onCaring = nil
  robo.drawSprite.sprite = Assets.robot_standing
  World:notifyChange(robo)
end

return system
