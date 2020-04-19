local system = Tiny.processingSystem({
  filter = Tiny.filter('hadleInput')
})

function system:process(e)
  for action,obj in pairs(e.hadleInput) do
    if love.keyboard.isScancodeDown(obj.scancode) then 
      obj.isDown = true
    else
      obj.isDown = false
      obj.used = nil
      -- for k,v in pairs(obj) do
      --   if k ~= 'isDown' then  
      --     obj[k] = nil
      --   end
      -- end
    end
  end
  World:notifyChange(e)
end

return system
