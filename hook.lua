local Hook = {}

local scale = 2

function Hook:new()
    local hook = {
        x = WIDTH/2-100,
        y = 100,
        speed = 500,
        width = hookImage:getWidth() * scale,
        height = hookImage:getHeight() * scale,
    }
    setmetatable(hook, { __index = Hook })
    return hook
end

function Hook:load()
end

function Hook:update(dt)
    if FISHING_PHASE == true and CATCHING_PHASE == false then
        self:movement(dt)
    end
end

function Hook:movement(dt)
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end

    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    end

    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed * 1.25 * dt
    end

    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * 0.8 * dt
    end
end

function Hook:collision(p)
    local fishLeft = p.x - p.width/2
    local fishRight = p.x + p.width/2 - 50
    local fishTop = p.y + p.height/2
    local fishBottom = p.y + p.height
  
    -- Check if any corner of the hook rectangle is inside the fish rectangle
    local hookCorners = {
      { self.x, self.y },                             -- Top-left corner
      { self.x + self.width, self.y },                -- Top-right corner
      { self.x, self.y + self.height },               -- Bottom-left corner
      { self.x + self.width, self.y + self.height }   -- Bottom-right corner
    }
  
    for _, corner in ipairs(hookCorners) do
      local cornerX, cornerY = unpack(corner)
      if cornerX >= fishLeft and cornerX <= fishRight and cornerY >= fishTop and cornerY <= fishBottom then
        return true
      end
    end
  
    return false
end

function Hook:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(hookImage, self.x, self.y, 0, scale, scale)

    --Hook's string
    love.graphics.line(self.x+self.width/2, 0, self.x+self.width/2, self.y)
end

return Hook