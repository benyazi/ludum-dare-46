local system = Tiny.processingSystem()

system.filter = Tiny.requireAll('targetSmooth','position')

local lerpMove = function(a, b, t)
    return a + (b - a) * t
end

function system:process(e)
  local cx,cy = Camera:position()
  local camX = lerpMove(cx, e.position.x, .2)
  local camY = lerpMove(cy, e.position.y, .2)
  Camera:lookAt(camX, camY)
end


return system
