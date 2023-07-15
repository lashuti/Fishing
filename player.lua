local Player = {}

local scale = 4

local playerWidth = playerImage:getWidth()
local playerHeight = playerImage:getHeight()

local widthDiff = 100
local spotScale = 6
local spotOffset = 30

local scaledSpotWidth = fishingSpotImage:getWidth() * spotScale
local scaledSpotHeight = fishingSpotImage:getHeight() * spotScale

function Player:new()
    local player = {
        x = 595,
        y = 105,
        speed = 500,
        direction = 1 -- 1 for right, -1 for left
    }
    setmetatable(player, { __index = Player })
    return player
end

function Player:load()
end

function Player:update(dt)
    self:movement(dt)
    self:startFishing(dt)

end

function Player:movement(dt)
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
        self.direction = -1
    end

    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
        self.direction = 1
    end

    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
    end

    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
    end
end

function Player:startFishing(dt)
    if love.keyboard.isDown("e") then
        if self.x > fishingSpotOneX - spotOffset and self.x < fishingSpotOneX + scaledSpotWidth + spotOffset
        and self.y > fishingSpotOneY - spotOffset and self.y < fishingSpotOneY + scaledSpotHeight + spotOffset then
            FISHING_PHASE = true
        elseif self.x > fishingSpotTwoX - spotOffset and self.x < fishingSpotTwoX + scaledSpotWidth + spotOffset
        and self.y > fishingSpotTwoY - spotOffset and self.y < fishingSpotTwoY + scaledSpotHeight + spotOffset then
            FISHING_PHASE = true
        end 
    end
end

function Player:render()
    --Moving Rect
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(playerImage, self.x, self.y, 0, self.direction * scale, scale, playerWidth /2, playerHeight /2)
end

return Player