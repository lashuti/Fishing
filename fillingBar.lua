local FillingBar = {}

local scale = 1

local widthDiff = 100
local x = WIDTH - widthDiff - 50

local heightDiff = 55
local y = heightDiff

local movingY = HEIGHT/2
local originalHeight = 435
local movingHeight = originalHeight

local growthRate = 70

function FillingBar:new()
    local fillingBar = {}
    setmetatable(fillingBar, { __index = FillingBar })
    return fillingBar
end

function FillingBar:load()
end

function FillingBar:update(dt)

    if catchingBar:touchingRoundFishy() and CATCHING_PHASE == true then
        --Growing
        movingHeight = movingHeight + growthRate * dt
        movingY = movingY - growthRate * dt
    else
        --Shrinking
        movingHeight = movingHeight - growthRate * dt
        movingY = movingY + growthRate * dt
    end

    --Reached the top
    if movingY <= y then
        CaughtFishCount = CaughtFishCount + 1
        self:endCatchingPhase(dt)
    end

    --Reached the bottom
    if movingY >= y+HEIGHT-heightDiff*2 then
        self:endCatchingPhase(dt)
    end

end

function FillingBar:endCatchingPhase(dt)
    FISHING_PHASE = false
    CATCHING_PHASE = false
    movingHeight = originalHeight
    movingY = HEIGHT/2

    hook.x = WIDTH/2-100
    hook.y = 100
end

function FillingBar:render()
    --Moving Rect
    love.graphics.setColor(0, 0, 1)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("fill", x, movingY, widthDiff, movingHeight)

    --Outline
    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(5)
    love.graphics.rectangle("line", x, y, widthDiff, HEIGHT-heightDiff*2)
end

return FillingBar