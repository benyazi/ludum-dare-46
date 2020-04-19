local ExitPoint = Class{}

function ExitPoint:init(x, y)
    self.size = {w=32, h=32}
    self.position = {x=x,y=y}
    self.drawSprite = {sprite = Assets.exit, level = 1.1, scale = {x=1,y=1}}
    self.isExit = true
end

return ExitPoint
