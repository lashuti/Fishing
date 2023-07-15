local CatchingBar = {}

local scale = 0.2

local widthDiff = 125
local x = WIDTH - widthDiff - 180

local heightDiff = 55
local y = heightDiff
local movingRectY = HEIGHT/2
local rectHeight = 180

local offsetFromOutline = 15

local movingBarTopRestraint = y + offsetFromOutline
local movingBarBottomRestraint = y+HEIGHT-heightDiff*2 - offsetFromOutline

local movingBarBottomRestraintForRect = movingBarBottomRestraint - rectHeight
local movingBarBottomRestraintForRoundFishy = movingBarBottomRestraint-roundFishyImageHeight * scale

local roundFishySpeed = 200

function CatchingBar:new()
    local catchingBar = {
        speed = 250,
        randomRoundFishyY = math.random(movingBarTopRestraint, movingBarBottomRestraintForRoundFishy)
    }
    setmetatable(catchingBar, { __index = CatchingBar })
    return catchingBar
end

function CatchingBar:load()
end

function CatchingBar:update(dt)
    if CATCHING_PHASE == true then
        self:barUpDownMovement(dt)
        self:roundFishyUpDownMovement(dt)
        self:touchingRoundFishy()
    end
end

function CatchingBar:touchingRoundFishy()
    local roundFishyMiddlePoint = self.randomRoundFishyY + roundFishyImageHeight*scale/2

    local movingRectStartingPoint = movingRectY
    local movingRectEndingPoint = movingRectY + rectHeight

    if roundFishyMiddlePoint >= movingRectStartingPoint and roundFishyMiddlePoint <= movingRectEndingPoint then
        return true
    else
        return false
    end

end

function CatchingBar:barUpDownMovement(dt)

    if love.keyboard.isDown("up") and movingRectY >= movingBarTopRestraint then
        movingRectY = movingRectY - self.speed * dt
    end

    if love.keyboard.isDown("down") and movingRectY <= movingBarBottomRestraintForRect then
        movingRectY = movingRectY + self.speed * dt
    end

end

function CatchingBar:roundFishyUpDownMovement(dt)
    --RoundFishy Movement
    self.randomRoundFishyY = self.randomRoundFishyY - roundFishySpeed * dt

    --0.2% Chance every frame for RoundFishy to change direction
    if math.random(1,1000) < 20 then
        roundFishySpeed = -roundFishySpeed
    end

    --If hit top, change RoundFishy's direction
    if self.randomRoundFishyY > movingBarTopRestraint then
        roundFishySpeed = -roundFishySpeed
    end

    --If hit bottom, change RoundFishy's direction
    if self.randomRoundFishyY < movingBarBottomRestraintForRoundFishy then
        roundFishySpeed = -roundFishySpeed
    end
end

function CatchingBar:render()
    --Moving Rect
    love.graphics.setColor(0, 1, 1)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("fill", x + offsetFromOutline, movingRectY, widthDiff-2*offsetFromOutline, rectHeight)

    --Moving Fish on Catching Bar
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(roundFishyImage, x + offsetFromOutline, self.randomRoundFishyY, 0, scale, scale)

    --Outline
    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(5)
    love.graphics.rectangle("line", x, y, widthDiff, HEIGHT-heightDiff*2)
end

return CatchingBar