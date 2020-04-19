local Children = Class{}

function Children:init(x, y, w, h)
    self.size = {w=w,h=h}
    self.position = {x=x,y=y}
    self.bulletCollide = true
    -- self.drawRect = Components.DrawRect(0.15,0.35,0.45)
    
    self.rigibody = {
        velocity = Vector(0,0),
        mass = 0.5
    }

    self.lootBox = {
        active = false
      }
    self.hadleInput = {
        useAction = {
            scancode = 'e',
            isDown = false
        },
        dropAction = {
            scancode = 'r',
            isDown = false
        }
    }
    self.heat = {
        current = 100,
        max = 100,
        perframe = 7
    }
    self.soundGenerator = {
        timer = 0,
        heatMin = 70
    }
    self.isChildren = true
    self.drawSprite = {sprite = Assets.baby, level = 1.1, scale = {x=1,y=1}}
end

return Children
