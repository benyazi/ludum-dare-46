local Robot = Class{}

function Robot:init(x, y, w, h)
    self.size = {w=w,h=h}
    self.position = {x=x,y=y}
    self.bulletCollide = true
    -- self.drawRect = Components.DrawRect(0.1,0.2,0.85)
    self.rigibody = {
        velocity = Vector(0,0),
        mass = 1,
        speed = 150,
        jump = 350
    }
    self.onCaring = nil
    self.health = {
        current = 100,
        max = 100
    }
    self.energy = {
        current = 100,
        max = 100
    }
    self.gravityGun = {
        radius = 300,
        speed = 100,
        energySize = 10
    }
    self.hadleInput = {
        gravityAction = {
            scancode = 'lshift',
            isDown = false
        }
    }
    self.heating = {
        heatSize = 20,
        energySize = 10
    }
    self.checkDownline = true
    self.isRobot = true
    self.canLoot = true
    self.targetSmooth = true
    self.drawSprite = {sprite = Assets.robot_standing, level = 1.1, scale = {x=1,y=1}}
end

return Robot
