function love.load()
  WIDTH = 1620
  HEIGHT = 980
  love.window.setMode(WIDTH, HEIGHT)
  love.window.setTitle("FishyFishing")

  FISHING_PHASE = false
  CATCHING_PHASE = false
  CAUGHT_FISH = false
  CaughtFishCount = 0

  oceanBG = love.graphics.newImage('assets/oceanBG.jpg')
  groundBG = love.graphics.newImage('assets/groundBG.png')
  fishingSpotImage = love.graphics.newImage('assets/fishingSpotGlow.png')
  fishingSpotImage:setFilter("nearest", "nearest")

  fishingSpotOneX = 400
  fishingSpotOneY = 360
  fishingSpotTwoX = 1030
  fishingSpotTwoY = 660


  fishImage = love.graphics.newImage('assets/fishFuture.png')
  fishImage:setFilter("nearest", "nearest")

  hookImage = love.graphics.newImage('assets/hook.png')
  hookImage:setFilter("nearest", "nearest")

  roundFishyImage = love.graphics.newImage('assets/roundFishy.png')
  roundFishyImage:setFilter("nearest", "nearest")
  roundFishyImageHeight = roundFishyImage:getHeight()

  playerImage = love.graphics.newImage('assets/player.png')
  playerImage:setFilter("nearest", "nearest")


  -- requiring files
  local playerModule = require('player')
  local fishModule = require('fish')
  local hookModule = require('hook')
  local fillingBarModule = require('fillingBar')
  local catchingBarModule = require('catchingBar')

  -- Set the random seed
  math.randomseed(os.time())

  -- Initialize game objects
  fishObjects = {} -- Table to store fish instances

  for i = 1, 10 do
    local fishy = fishModule:new(math.random(50, HEIGHT-30), math.random(50, HEIGHT-30), 100)
    table.insert(fishObjects, fishy)
  end

  fishToCatchSpeed = 175
  fishToCatch = fishModule:new(math.random(50, HEIGHT-30), math.random(50, HEIGHT-30), fishToCatchSpeed)
  r = math.random(0.1,0.9)
  g = math.random(0.1,0.9)
  b = math.random(0.1,0.9)

  player = playerModule:new()
  fillingBar = fillingBarModule:new()
  catchingBar = catchingBarModule:new()
  hook = hookModule:new()
end

function love.update(dt)

  if FISHING_PHASE == false then
    player:update(dt)
  end

  if FISHING_PHASE == true then
    fishToCatch:update(dt)
    hook:update(dt)
    fishToCatch.speed = fishToCatchSpeed

    for _, fishy in ipairs(fishObjects) do
      fishy:update(dt)
    end

    if love.keyboard.isDown("tab") then
      fillingBar:endCatchingPhase()
    end

    if hook:collision(fishToCatch) then
      CATCHING_PHASE = true
    end

    if CATCHING_PHASE == true then
      fishToCatch.speed = 0 --Start CHYAPACHYUPI animations
      fillingBar:update(dt)
      catchingBar:update(dt)
    end
  end
    
end
  
function love.draw()

  if FISHING_PHASE == false then
    love.graphics.setColor(1,1,1)
    love.graphics.draw(groundBG, 0, 0)
    love.graphics.draw(fishingSpotImage, fishingSpotOneX, fishingSpotOneY, 0, 6)
    love.graphics.draw(fishingSpotImage, fishingSpotTwoX, fishingSpotTwoY, 0, 6)
    player:render()
  end

  if FISHING_PHASE == true then
    love.graphics.setColor(1,1,1,0.75)
    love.graphics.draw(oceanBG, 0, 0)

    fishToCatch:render(r,g,b)
    for _, fishy in ipairs(fishObjects) do
      fishy:render(1,1,0)
    end

    hook:render()

    if CATCHING_PHASE == true then
      fillingBar:render()
      catchingBar:render()
    end
  end

  love.graphics.setColor(0,0,0,1)
  love.graphics.print("Caught Fish: " .. CaughtFishCount, WIDTH-100, 10)
end