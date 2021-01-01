function NewHorizontalAnimation(file, width, height, frameNums) --make a horizontal animation from a sprite sheet image
	local img = love.graphics.newImage(file)
	local animQuads = {}

	for i = 1, #frameNums do
		--frameNums is a list of frames to put into the animation. 0 for first frame
		local quad = love.graphics.newQuad(frameNums[i] * width, 0, width, height, img:getDimensions())	
		table.insert(animQuads, quad)
	end

	local anim = {quads = animQuads, image = img, frame = 1, time = 0}
	return anim
end

--note this just loops through the frames. if you want to do something frame-specific you will need your own logic
function UpdateAnimation(dt, anim, speedSeconds) 
	anim.time = anim.time + dt

	if (anim.time % (speedSeconds + 1)) > speedSeconds then 
		anim.frame = anim.frame + 1
		anim.time = 0
		if anim.frame > #anim.quads then 
			anim.frame = 1
		end
	end
end

function DrawAnimation(anim, x, y, r, offsetx, offsety)	--note it's ok if r (angle radians) is nil so you don't have to pass it
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(anim.image, anim.quads[anim.frame], x, y, r, 1, 1, offsetx, offsety)
end

--physics draw functions

function DrawPhysics(o, color)
	love.graphics.setColor(color[1], color[2], color[3], color[4]) -- set the drawing color to green for the ground
  	love.graphics.polygon("fill", o.physics.body:getWorldPoints(o.physics.shape:getPoints()))
end

function DrawPhysicsImage(o, image, offsetx, offsety)
	love.graphics.setColor(1, 1, 1, 1)
	local x, y = GetPolygonCenter(o)
	love.graphics.draw(image, x, y, o.physics.body:getAngle(), 1, 1, offsetx, offsety)
end

function DrawPhysicsAnimation(o, anim, offsetx, offsety)
	love.graphics.setColor(1, 1, 1, 1)
	local x, y = GetPolygonCenter(o)
	love.graphics.draw(anim.image, anim.quads[anim.frame], x, y, o.physics.body:getAngle(), 1, 1, offsetx, offsety)
end