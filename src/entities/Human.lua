local Human = Class{}

function Human:init(x, y, w, h)
    self.size = {w=w,h=h}
    self.position = {x=x,y=y}
    -- self.drawRect = Components.DrawRect(0.85,0.15,0.15)
    self.drawSprite = {sprite = Assets.gunner_a_001, level = 1.1, scale = {x=1,y=1}}
    self.rigibody = {
        velocity = Vector(0,0),
        mass = 1
    }
    self.isHuman = true
    self.state = 'idle'
    self.shootingTimer = 0.5
end

return Human
