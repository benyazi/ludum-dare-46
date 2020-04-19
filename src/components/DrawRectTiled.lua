local DrawRectTiled = Class{}

function DrawRectTiled:init(img, wc, hc)
    self.tile = img
    self.wc = wc
    self.hc = hc
    self.tileH = img:getHeight()
    self.tileW = img:getWidth()
end

return DrawRectTiled
