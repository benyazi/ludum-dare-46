local ExitPoint = Class{}

function ExitPoint:init(x, y, isDoom)
    self.size = {w=32, h=32}
    self.position = {x=x,y=y}
    local img = Assets.exit
    if isDoom then 
        img = Assets.exit_doom
    end
    self.drawSprite = {sprite = img, level = 1.1, scale = {x=1,y=1}}
    self.isExit = true
end

return ExitPoint
