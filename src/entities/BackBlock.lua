local BackBlock = Class{}

function BackBlock:init(type, x, y)
    local img = nil
    local level = 1.05
    if type == 'armature1' then
        level = 1.03
        img = Assets.armature1
    elseif type == 'armature2' then
        level = 1.04
        img = Assets.armature2
    elseif type == 'kafel' then
        level = 1.02
        img = Assets.kafel
    elseif type == 'racks' then
        level = 1.025
        img = Assets.racks
    elseif type == 'snow' then
        level = 1.07
        img = Assets.snow
    elseif Assets[type] ~= nil then 
        level = 1.045
        img = Assets[type]
    end
    if img then
        local tileH = img:getHeight()
        local tileW = img:getWidth()
        self.size = {w=tileW, h=tileH}
        self.position = {x=x,y=y}
        self.drawSprite = {sprite = img, level = level, scale = {x=1,y=1}}
    else
        self.size = {w=32, h=32}
        self.position = {x=x,y=y}
        self.drawRect = Components.DrawRect(0.85,0.15,0.15)
    end
end

return BackBlock
