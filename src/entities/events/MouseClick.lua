local MouseClick = Class{}

function MouseClick:init(x, y, btn)
  local cameraX, cameraY = x, y
  local worldX, worldY = Camera:worldCoords(x,y)
  self.mouseSelectPosition = {
    cameraX=cameraX,
    cameraY=cameraY,
    worldX=worldX,
    worldY=worldY,
    endCameraX=cameraX,
    endCameraY=cameraY,
    endWorldX=worldX,
    endWorldY=worldY,
    button=btn
  }
end

return MouseClick
