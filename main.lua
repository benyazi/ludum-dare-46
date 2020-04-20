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

DEV = true
GRAVITY = -500
SCENE = 'main_menu'
FONT_SIZE = 18

CAM_SCALE = 1.5

function love.load()
  love.graphics.setBackgroundColor(0.32,0.32,0.32)
  love.window.setTitle( 'Only One Way' )
  FontDefault = love.graphics.newFont("assets/AldotheApache.ttf", FONT_SIZE)
  Font_12 = love.graphics.newFont("assets/AldotheApache.ttf", 12)
  Font_10 = love.graphics.newFont("assets/AldotheApache.ttf", 10)
  Font_32 = love.graphics.newFont("assets/AldotheApache.ttf", 32)
  -- load all image, sound and etc.
  Assets.load()
  --  save window size to global
  WindowHeight = love.graphics.getHeight()
  WindowWidth = love.graphics.getWidth()
  --  Create camera instanse and set zoom value
  Camera = camera(WindowWidth/2,WindowHeight/2)
  
  Camera:zoomTo(CAM_SCALE)
-- set random seed
  math.randomseed(os.time())

  music = love.audio.newSource( 'assets/wind.flac', 'stream' )
  music:setLooping( true ) --so it doesnt stop
  music:setVolume(1)
  music:play()
end

function generateMap(levelName)
  -- local levelName = 'level_1'
	local jsonString = love.filesystem.read('src/maps/' .. levelName .. '.json')
  local levelData = json.decode(jsonString)
  
  local mapData = levelData.map 
  if levelData.messages then
    for i, msgItem in pairs(levelData.messages) do
      World:addEntity({isMsg=true,text=msgItem.text,index=i})
    end
  end
  
  for i, mapItem in pairs(mapData) do
    local posX, posY = mapItem.pos.i * 32, mapItem.pos.j * 32
    if mapItem.type == 'exit' then
      if levelName == 'level_last' then 
        World:addEntity(Entities.ExitPoint(posX, posY, true))
      else
        World:addEntity(Entities.ExitPoint(posX, posY))
      end
    elseif mapItem.type == 'pipe_huge_elbow' 
    or mapItem.type == 'pipe_huge_elbow2'
    or mapItem.type == 'pipe_huge_elbow3'
    or mapItem.type == 'pipe_huge_elbow4'
    or mapItem.type == 'pipe_huge_elbow_back'
    or mapItem.type == 'pipe_huge_elbow_front_open'
    or mapItem.type == 'pipe_huge_elbow_front_closed'
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
    elseif mapItem.type == 'ladder' then
      World:addEntity(Entities.Ladder(posX, posY, 32, 32))
    elseif mapItem.type == 'energy' then
      World:addEntity(Entities.Energy(posX, posY, 32, 32))
    elseif mapItem.type == 'robot_caring' then
      ROBOT = Entities.Robot(posX, posY, 32, 32)
      World:addEntity(ROBOT)
      World:addEntity(Entities.Children(posX + 32 + 16, posY, 16, 16))
    else
      World:addEntity(Entities.BackBlock(mapItem.type, posX, posY))
    end
    if DOWNLINE < posY then 
      DOWNLINE = posY
    end
  end
  -- World:addEntity(Entities.Human(128,WindowHeight-192, 32, 32))
  -- World:addEntity(Entities.Platform(128,WindowHeight-128, 4, 1))
  -- World:addEntity(Entities.Platform(256,WindowHeight-224, 4, 1))
end

function love.draw()
  love.graphics.setFont(FontDefault)
  if SCENE == 'main_menu' then
    love.graphics.setFont(Font_32)
    love.graphics.print('Only one way', WindowWidth/2 - 100, WindowHeight/2 - 100)
    love.graphics.setFont(FontDefault)

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

  if SCENE == 'level' and love.keyboard.isScancodeDown('q') and CAM_SCALE > 0.5 then 
    CAM_SCALE = CAM_SCALE - 1*dt
    if CAM_SCALE == 0.5 or CAM_SCALE < 0.51 then 
      CAM_SCALE = 0.5
    else 
      Camera:zoomTo(CAM_SCALE)
    end
  elseif SCENE == 'level' and CAM_SCALE < 1.5 then
    CAM_SCALE = CAM_SCALE + 1*dt
    if CAM_SCALE > 1.5 then 
      CAM_SCALE = 1.5
    end
    Camera:zoomTo(CAM_SCALE)
  end
end

function love.mousepressed(x, y, button)
  -- World:addEntity(Entities.events.MouseClick(x,y,button))
end

LevelSystems = {
    Systems.camera.TargetSmooth,
    Systems.draw.DrawRectTiledSystem,
    Systems.input.HandleInput,
    Systems.loot.CheckActive,
    Systems.dev.DrawFpsSystem,
    Systems.draw.FlipSprite,
    Systems.draw.DrawSprite,
    Systems.draw.DrawRectSystem,
    Systems.robot.LadderDetect,
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
    Systems.children.UpdateHeatOnHands,
    Systems.children.UpdateHeatLevel,
    Systems.children.DrawHeatLevel,
    Systems.children.CheckDrop,
    Systems.children.DropChildren,
    Systems.children.GenerateSound,
    Systems.children.LetterAMoving,
    Systems.physics.Gravity,
    Systems.robot.UseGravity,
    Systems.robot.UseHeating,
    Systems.robot.DrawGravityGunRadius,
    Systems.robot.EnergyDetect,
    Systems.robot.CheckEnergyLevel,
    Systems.robot.DrawEnergyLevel,
    Systems.draw.DrawLevelMessage,
    Systems.robot.UseGravityClear,
    Systems.clear.ClearEventSystem,
    Systems.clear.RemoveTimer,
    Systems.exit.ExitEnter,
    Systems.exit.ExitEvent,
    Systems.clear.CheckDownline
}
LevelLastSystemsForRemove = {
  Systems.human.ShootDetect,
  Systems.human.Shooting,
  Systems.exit.ExitEnter,
  Systems.exit.ExitEvent
}
LevelLastSystems = {
  Systems.camera.TargetSmooth,
  Systems.draw.DrawRectTiledSystem,
  Systems.input.HandleInput,
  Systems.loot.CheckActive,
  Systems.dev.DrawFpsSystem,
  Systems.draw.FlipSprite,
  Systems.draw.DrawSprite,
  Systems.draw.DrawRectSystem,
  Systems.robot.LadderDetect,
  Systems.physics.UpdateOnPlatform,
  Systems.physics.VelocityMoving,
  Systems.loot.DrawActiveText,
  Systems.loot.CheckButton,
  Systems.loot.OpenLootbox,
  Systems.loot.LootObject,
  Systems.human.BulletMoving,
  Systems.human.BulletCollition,
  Systems.children.UpdateOnhandsPosition,
  Systems.children.UpdateHeatOnHands,
  Systems.children.UpdateHeatLevel,
  Systems.children.DrawHeatLevel,
  Systems.children.CheckDrop,
  Systems.children.DropChildren,
  Systems.children.GenerateSound,
  Systems.children.LetterAMoving,
  Systems.physics.Gravity,
  Systems.robot.UseGravity,
  Systems.robot.UseHeating,
  Systems.robot.DrawGravityGunRadius,
  Systems.robot.EnergyDetect,
  Systems.robot.CheckEnergyLevel,
  Systems.robot.DrawEnergyLevel,
  Systems.draw.DrawLevelMessage,
  Systems.robot.UseGravityClear,
  Systems.clear.ClearEventSystem,
  Systems.clear.RemoveTimer,
  Systems.exit.ExitEnterFinal,
  Systems.exit.ExitEventDoomFinal,
  Systems.exit.ExitEventLiveFinal,
  Systems.clear.CheckDownline
}

Levels = {"level_1","level_2","level_3","level_4","level_5","level_6","level_7"}

LoadLevel = nil

function gotoScene(name, adv)
  World:clearWorld()
  if name == 'level' then
    print('Start load level ' .. adv)
    
    if Levels[adv] == nil and adv == -1 then 
      SCENE = 'main_menu'
      if SCREEN_MESSAGE == nil then
        SCREEN_MESSAGE = 'GAME WIN' 
      end
      print('Not found, return to main menu ')
      CURRENT_LEVEL = 1
      return
    elseif Levels[adv] == nil then 
      print('Load final level')
      print('Load systems')
      for k,v in pairs(LevelLastSystemsForRemove) do
        World:removeSystem(v)
      end
      for k,v in pairs(LevelLastSystems) do
        World:addSystem(v)
      end
      SCENE = 'level'
      print('Generate map for level_last')
      generateMap('level_last')
    else
      CURRENT_LEVEL = adv
      print('Load systems')
      for k,v in pairs(LevelSystems) do
        World:addSystem(v)
      end
      SCENE = 'level'
      print('Generate map for ' .. Levels[adv])
      generateMap(Levels[adv])
    end
  end
  -- Add sumply entity for print FPS system
  World:addEntity({drawFps = true})
end

function nextLevel()
  local nextLevelNumber = CURRENT_LEVEL + 1
  print('Go to next level: ' .. nextLevelNumber)
  LoadLevel = {
    Timer = 0.3,
    level = nextLevelNumber
  }
  SCENE = 'loading'
  -- gotoScene('level', nextLevelNumber)
end

SCREEN_MESSAGE = nil
DOWNLINE = 0

function gameOver(reason)
  if DEV then 
    gotoScene('level', CURRENT_LEVEL)
  else
    SCREEN_MESSAGE = 'GAME OVER'
    if reason then 
      SCREEN_MESSAGE = SCREEN_MESSAGE .. '. ' .. reason
    end
    gotoScene('level', -1)
  end
end

function gameWin(reason)
  SCREEN_MESSAGE = 'GAME WIN' .. reason
  gotoScene('level', -1)
end

function love.keypressed(key, scancode, isrepeat)
  if SCENE == 'main_menu' and scancode == 'return' then
    LoadLevel = {
      Timer = 0.3,
      level = 1
    }
    SCENE = 'loading'
    -- gotoScene('level', 1)
  end

  if DEV then
    if pcall(function ()
      local level = tonumber(scancode);
      if love.keyboard.isScancodeDown('lctrl') then 
        level = level + 10
      end
      print('GOTO ' .. level);
      LoadLevel = {
        Timer = 0.3,
        level = level
      }
      SCENE = 'loading'
    end) then
      
    end 
  end
end

function love.keyreleased(k, scancode)
end
