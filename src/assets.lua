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
	image('asphalth_h','assets/sprites/asphalth_h.png')
	image('alphalth_snowy_p','assets/sprites/alphalth_snowy_p.png')
	image('sosuli','assets/sprites/sosuli.png')
	image('sosuli_up','assets/sprites/sosuli_up.png')
	image('ladder','assets/sprites/ladder.png')
	image('chair_and_table','assets/sprites/chair_and_table.png')
	image('door_open','assets/sprites/door_open.png')
	image('door_close','assets/sprites/door_close.png')
	image('wires','assets/sprites/wires.png')
	image('siding','assets/sprites/siding.png')

	image('pipe_huge_elbow','assets/sprites/pipe_huge_elbow.png')
	image('pipe_huge_elbow2','assets/sprites/pipe_huge_elbow2.png')
	image('pipe_huge_elbow3','assets/sprites/pipe_huge_elbow3.png')
	image('pipe_huge_elbow4','assets/sprites/pipe_huge_elbow4.png')
	image('pipe_huge_elbow_back','assets/sprites/pipe_huge_elbow_back.png')
	image('pipe_huge_elbow_front_closed','assets/sprites/pipe_huge_elbow_front_closed.png')
	image('pipe_huge_elbow_front_open','assets/sprites/pipe_huge_elbow_front_open.png')
	image('pipe_huge_v','assets/sprites/pipe_huge_v.png')
	image('pipe_huge','assets/sprites/pipe_huge.png')

	image('snow2','assets/sprites/snow2.png')
	image('platform','assets/sprites/platform.png')
	image('platform_snowy','assets/sprites/platform_snowy.png')
	image('racks2','assets/sprites/racks2.png')
	image('bricks','assets/sprites/bricks.png')
	image('beton','assets/sprites/beton.png')
	
	image('exit','assets/sprites/exit.png')
	image('exit_doom','assets/sprites/exit_doom.png')
	
	image('letterA','assets/sprites/a_letter.png')

	image('energy','assets/sprites/energy.png')

	image('gunner_a','assets/sprites/gunner_a.png')
	image('gunner_a_001','assets/sprites/gunner_a_001.png')

	image('game_over','assets/game_over.png')
	image('game_win','assets/game_win.png')
end

return assets
