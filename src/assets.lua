local assets = {}

local function image(name, fp)
	assets[name] = love.graphics.newImage(fp)
	-- for pixel art you may add this filter
	assets[name]:setFilter('nearest', 'nearest')
end

local function imageData(name, fp)
	assets[name] = love.image.newImageData(fp)
end

function assets.load()
	image('arrow_up','assets/sprites/arrow_up.png')
	image('arrow_down','assets/sprites/arrow_down.png')
	image('arrow_left','assets/sprites/arrow_left.png')
	image('arrow_right','assets/sprites/arrow_right.png')
	image('mario','assets/sprites/mario.png')
	image('hole','assets/sprites/hole.png')
	image('pump','assets/sprites/pump.png')
	image('ship','assets/sprites/ship.png')
	image('robot_caring','assets/sprites/robot_caring.png')
	image('robot_standing','assets/sprites/robot_standing.png')
	image('baby','assets/sprites/baby.png')

	image('platform_icy','assets/sprites/platform_icy_croped.png')
	image('armature1','assets/sprites/armature1.png')
	image('armature2','assets/sprites/armature2.png')
	image('armature2','assets/sprites/armature2.png')
	image('racks','assets/sprites/racks.png')
	image('kafel','assets/sprites/kafel_big.png')
	image('snow','assets/sprites/snow.png')
	image('asphalth','assets/sprites/asphalth.png')
	image('alphalth_snowy_p','assets/sprites/alphalth_snowy_p.png')
	
	image('exit','assets/sprites/exit.png')
	image('letterA','assets/sprites/a_letter.png')
end

return assets
