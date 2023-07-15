local Fish = {}

local scale = 0.25

function Fish:new(x,y,speed)
    local fish = {
        x = x,
        y = y,
        speed = speed,
        width = fishImage:getWidth() * scale,
        height = fishImage:getHeight() *scale,
        direction = 1 -- 1 for right, -1 for left
    }
    setmetatable(fish, { __index = Fish })
    return fish
end

function Fish:load(dt)
  local screenWidth = love.graphics.getWidth()
end

function Fish:update(dt)
    self:swimAround(dt)
end

function Fish:swimAround(dt)
  if self.x + 35 >= WIDTH or self.x <= 35 then
    self.direction = -self.direction
  end

   self.x = self.x + self.speed * self.direction * dt
end

function Fish:render(r,g,b)
    love.graphics.setColor(r,g,b,1)
    love.graphics.draw(fishImage, self.x, self.y, 0, self.direction * scale, scale, self.width*4/2, self.height*4/2)
end

return Fish
