local system = Tiny.processingSystem({
  filter = Tiny.filter('soundGenerator&position')})

function system:onAdd(e)

end

function system:process(e,dt)
  if e.heat.current < e.soundGenerator.heatMin then
    if e.generatingSound == nil then 
      e.generatingSound = true
    end
    if e.soundGenerator.timer < 0 then
      local letterA = {
        position = {
          x = e.position.x,
          y = e.position.y
        },
        drawSprite = {sprite = Assets.letterA, level = 2, scale = {x=1,y=1}},
        rad = -math.pi/2,
        removeTimer = 1.5,
        isLetterA = true
      }
      World:addEntity(letterA)
      e.soundGenerator.timer = 0.3
      World:notifyChange(e)
    else
      e.soundGenerator.timer = e.soundGenerator.timer-dt
      World:notifyChange(e)
    end 
  else 
    if e.generatingSound ~= nil then 
      e.generatingSound = nil
      World:notifyChange(e)
    end
  end
end

return system
