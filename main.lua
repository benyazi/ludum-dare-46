--load libs
json = require "lib.json"
require 'lib.require'
local camera = require 'lib.hump.camera'
Vector = require 'lib.hump.vector'
Class = require 'lib.hump.class'
Anim8 = require 'lib.anim8.anim8'
Assets = require 'src.assets'
Tiny = require 'lib.tiny-ecs.tiny'
Inspect = require 'lib.inspect.inspect'
Bump = require 'lib.bump.bump'
Beholder = require 'lib.beholder'

-- load world
local world = require 'src.world'

--load ecs
Components = require.tree('src.components')
Entities = require.tree('src.entities')
Systems = require.tree('src.systems')

-- create new world
World = world:new(
  Bump.newWorld(16),
  Systems.dev.DrawFpsSystem
)

--  create system filters
local drawFilter = Tiny.requireAll('isDrawSystem')
local drawGuiFilter = Tiny.requireAll('isDrawGuiSystem')
local updateFilter = Tiny.rejectAny('isDrawSystem','isDrawGuiSystem')

GRAVITY = -500
SCENE = 'main_menu'

function love.load()
  love.graphics.setBackgroundColor(0.32,0.32,0.32)
  love.window.setTitle( 'Only One Way' )
  -- load all image, sound and etc.
  Assets.load()
  --  save window size to global
  WindowHeight = love.graphics.getHeight()
  WindowWidth = love.graphics.getWidth()
  --  Create camera instanse and set zoom value
  Camera = camera(WindowWidth/2,WindowHeight/2)
  local cam_scale = 1.5
  Camera:zoomTo(cam_scale)
-- set random seed
  math.randomseed(os.time())

  -- generateMap()
  
end

function generateMap(levelName)
  -- local levelName = 'level_1'
	local jsonString = love.filesystem.read('src/maps/' .. levelName .. '.json')
  local levelData = json.decode(jsonString)
  
  local mapData = levelData.map 
  
  for i, mapItem in pairs(mapData) do
    local posX, posY = mapItem.pos.i * 32, mapItem.pos.j * 32
    if mapItem.type == 'exit' then
      World:addEntity(Entities.ExitPoint(posX, posY))
    elseif mapItem.type == 'pipe_huge_elbow' 
    or mapItem.type == 'pipe_huge_elbow2'
    or mapItem.type == 'pipe_huge_elbow3'
    or mapItem.type == 'pipe_huge_elbow4'
    or mapItem.type == 'pipe_huge_v'
    or mapItem.type == 'pipe_huge'
    or mapItem.type == 'asphalth_h'
    or mapItem.type == 'alphalth_snowy_p'
    or mapItem.type == 'asphalth'
    or mapItem.type == 'platform_icy'
    or mapItem.type == 'platform'
    or mapItem.type == 'platform_snowy'
    or mapItem.type == 'snow2'
    or mapItem.type == 'bricks'
    then
      World:addEntity(Entities.Platform(Assets[mapItem.type], posX, posY))
    elseif mapItem.type == 'human' then
      World:addEntity(Entities.Human(posX, posY, 32, 32))
    elseif mapItem.type == 'robot_caring' then
      ROBOT = Entities.Robot(posX, posY, 32, 32)
      World:addEntity(ROBOT)
      World:addEntity(Entities.Children(posX + 32 + 16, posY, 16, 16))
    else
      World:addEntity(Entities.BackBlock(mapItem.type, posX, posY))
    end
  end
  -- World:addEntity(Entities.Human(128,WindowHeight-192, 32, 32))
  -- World:addEntity(Entities.Platform(128,WindowHeight-128, 4, 1))
  -- World:addEntity(Entities.Platform(256,WindowHeight-224, 4, 1))
end

function love.draw()
  if SCENE == 'main_menu' then
    love.graphics.print('Press Enter to start', WindowWidth/2 - 100, WindowHeight/2)
    if SCREEN_MESSAGE then 
      love.graphics.print(SCREEN_MESSAGE, WindowWidth/2 - 100, WindowHeight/2 - 50)
    end
  elseif SCENE == 'loading' then
    if LoadLevel then 
      local percent = 100 - LoadLevel.Timer*100
      love.graphics.print('Loading > '.. math.floor(percent) .. '%', WindowWidth/2 - 100, WindowHeight/2)
    end
  elseif SCENE == 'level' then
    Camera:attach() --switch to camera scope
      World:update(love.timer.getDelta(), drawFilter)
    Camera:detach() --return from camera scope
    World:update(love.timer.getDelta(), drawGuiFilter)
  end
end

function love.update(dt)
  if LoadLevel then 
    LoadLevel.Timer = LoadLevel.Timer - dt
    if LoadLevel.Timer <= 0 then 
      gotoScene('level', LoadLevel.level)
      LoadLevel = nil
    end
  else
    World:update(dt,updateFilter)
  end
end

function love.mousepressed(x, y, button)
  -- World:addEntity(Entities.events.MouseClick(x,y,button))
end

LevelSystems = {
    Systems.camera.TargetSmooth,
    Systems.draw.DrawRectSystem,
    Systems.draw.DrawRectTiledSystem,
    Systems.input.HandleInput,
    Systems.loot.CheckActive,
    Systems.dev.DrawFpsSystem,
    Systems.draw.FlipSprite,
    Systems.draw.DrawSprite,
    Systems.physics.UpdateOnPlatform,
    Systems.physics.VelocityMoving,
    Systems.loot.DrawActiveText,
    Systems.loot.CheckButton,
    Systems.loot.OpenLootbox,
    Systems.loot.LootObject,
    Systems.human.ShootDetect,
    Systems.human.Shooting,
    Systems.human.BulletMoving,
    Systems.human.BulletCollition,
    Systems.children.UpdateOnhandsPosition,
    Systems.children.UpdateHeatLevel,
    Systems.children.DrawHeatLevel,
    Systems.children.CheckDrop,
    Systems.children.DropChildren,
    Systems.children.GenerateSound,
    Systems.children.LetterAMoving,
    Systems.physics.Gravity,
    Systems.clear.ClearEventSystem,
    Systems.clear.RemoveTimer,
    Systems.exit.ExitEnter,
    Systems.exit.ExitEvent
}

Levels = {"level_1","level_2","level_3"}

LoadLevel = nil

function gotoScene(name, adv)
  World:clearWorld()
  if name == 'level' then
    print('Start load level ' .. adv)
    
    if Levels[adv] == nil then 
      SCENE = 'main_menu'
      if SCREEN_MESSAGE == nil then
        SCREEN_MESSAGE = 'GAME WIN' 
      end
      print('Not found, return to main menu ')
      CURRENT_LEVEL = 1
      return
    end
    CURRENT_LEVEL = adv
    print('Load systems')
    for k,v in pairs(LevelSystems) do
      World:addSystem(v)
    end
    SCENE = 'level'
    print('Generate map for ' .. Levels[adv])
    generateMap(Levels[adv])
  end
  -- Add sumply entity for print FPS system
  World:addEntity({drawFps = true})
end

function nextLevel()
  local nextLevelNumber = CURRENT_LEVEL + 1
  print('Go to next level: ' .. nextLevelNumber)
  LoadLevel = {
    Timer = 1,
    level = nextLevelNumber
  }
  SCENE = 'loading'
  -- gotoScene('level', nextLevelNumber)
end

SCREEN_MESSAGE = nil

function gameOver(reason)
  SCREEN_MESSAGE = 'GAME OVER'
  gotoScene('level', -1)
end

function gameWin()
  SCREEN_MESSAGE = 'GAME WIN'
  gotoScene('level', -1)
end

function love.keypressed(key, scancode, isrepeat)
  if SCENE == 'main_menu' and scancode == 'return' then
    LoadLevel = {
      Timer = 1,
      level = 1
    }
    SCENE = 'loading'
    -- gotoScene('level', 1)
  end
end

function love.keyreleased(k, scancode)
end
