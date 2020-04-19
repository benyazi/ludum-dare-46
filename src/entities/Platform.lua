local Platform = Class{}

function Platform:init(img, x, y)

    -- local img = Assets.platform_icy

    local tileH = img:getHeight()
    local tileW = img:getWidth()

    self.size = {w=tileW, h=tileH}
    self.position = {x=x,y=y}
    self.drawSprite = {sprite = img, level = 1.1, scale = {x=1,y=1}}
    self.isPlatform = true
    self.bulletCollide = true
end

return Platform
