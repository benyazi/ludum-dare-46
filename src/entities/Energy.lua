local Energy = Class{}

function Energy:init(x, y, w, h)
    self.size = {w=w,h=h}
    self.position = {x=x,y=y}
    self.drawSprite = {sprite = Assets.energy, level = 1.1, scale = {x=1,y=1}}
    self.isEnergy = true
    self.energySize = 10
end

return Energy
