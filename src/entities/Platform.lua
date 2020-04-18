local Platform = Class{}

function Platform:init(x, y, w, h)
    self.size = {w=w,h=h}
    self.position = {x=x,y=y}
end

return Platform
