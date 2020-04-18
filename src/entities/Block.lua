local Block = Class{}

function Block:init(x, y, w, h)
    self.size = {w=w,h=h}
    self.position = {x=x,y=y}
end

return Block
