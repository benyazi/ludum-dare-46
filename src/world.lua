local m = {}

function m:new(physics, ...)
   local world = Tiny.world(unpack({...}))
   return setmetatable({entities={}, world=world, physics=physics}, {__index=self})
end

function m:add()
end

function m:addEntity(e)
   if e.size and e.position and not self.physics:hasItem(e) then
     local x, y = e.position.x, e.position.y
     if e.size.offset then
       if e.size.offset.x then
        x = x + e.size.offset.x
       end
       if e.size.offset.y then
        y = y + e.size.offset.y
       end
      end
      self.physics:add(e, x, y, e.size.w, e.size.h)
   end
	self.entities[e] = e
	return self.world:addEntity(e)
end

function m:addSystem(s)
	if s.world ~= self.world then
		return self.world:addSystem(s)
	end
end


function m:removeEntity(e)
    if e.size and e.position and self.physics:hasItem(e) then
      self.physics:remove(e)
    end
   self.entities[e] = nil
   return self.world:removeEntity(e)
end


function m:removeSystem(s)
   if s.world == self.world then
      return self.world:removeSystem(s)
   end
   print("System doesn't belong to this world")
end

function m:notifyChange(e)
	return self:addEntity(e)
end


function m:clearWorld()
   Tiny.clearEntities(self.world)
   -- Tiny.clearSystems(self.world)
   for k,v in pairs(self.entities) do
      self:removeEntity(v)
      v = nil
   end
   Tiny.refresh(self.world)
end

function m:update(dt, filter)
	return self.world:update(dt, filter)
end

return m
