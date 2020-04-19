local system = Tiny.processingSystem({
  filter = Tiny.filter('lootBox&lootBoxOpenEvent')})

function system:onAdd(e)

end

function system:process(e,dt)
  local randType = math.random(1,5)
  local curX, curY = e.position.x, e.position.y
  if randType == 1 then 
    World:addEntity(Entities.weapon.Ammunition(curX+16, curY+16))
    -- World:addEntity(Entities.weapon.Weapon1(curX+16, curY+16))
  elseif randType == 2 then 
    World:addEntity(Entities.weapon.Weapon2(curX+16, curY+16))
  elseif randType == 3 then 
    World:addEntity(Entities.weapon.Pills(curX+16, curY+16))
  elseif randType == 5 then 
    World:addEntity(Entities.weapon.Shield(curX+16, curY+16))
  elseif randType == 4 then 
    World:addEntity(Entities.weapon.Weapon3(curX+16, curY+16))
  end
  World:removeEntity(e)
  e = nil
end

return system
