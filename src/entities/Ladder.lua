local Ladder = Class{}

function Ladder:init(x, y, w, h)
    self.size = {w=w,h=h}
    self.position = {x=x,y=y}
    self.drawSprite = {sprite = Assets.ladder, level = 1.1, scale = {x=1,y=1}}
    self.isLadder = true
end

return Ladder
