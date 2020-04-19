local system = Tiny.processingSystem({
    filter = Tiny.filter('removeTimer')})
  
  function system:onAdd(e)
  
  end
  
  function system:process(e, dt)
    if e.removeTimer > 0 then 
      e.removeTimer = e.removeTimer - dt
    else
      World:removeEntity(e)
      e = nil
    end
  end
  
  return system