require 'src/Dependencies'

window_width=1280
window_height=600
cam = camera()
clones={}
clonex={}
cloney={}
i=1
player = Player(0,0)
function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end
function love.load()
    bg_music = love.audio.newSource('sounds/WhatsApp Audio 2023-12-07 at 23.15.19_694823d0.mp3','stream')
    gStateMachine = StateMachine {
        ['menu'] = function() return Menu() end,
        ['map0'] = function() return Map0() end,
        ['map1'] = function() return Map1() end,
        ['map2'] = function() return Map2() end,
        ['end'] = function() return End() end
           
        
    }
    gStateMachine:change('menu')
    love.window.setMode(window_width,window_height)
    love.keyboard.keysPressed = {}
end
function love.update(dt)
   -- bg_music:play()
    world:update(dt)
    gStateMachine:update(dt)
    player:update(dt)   
    table.insert(clonex,player.collider:getX())
    table.insert(cloney,player.collider:getY())
    if love.keyboard.wasPressed('c') and i <=5  then          
        obj=Clone(clonex,cloney,'clone'..tostring(i))
        table.insert(clones,obj)
        clonex={} 
        cloney={}
        gStateMachine:reset()
        for k,v in pairs(clones) do
            v.reset=true
        end
        i=i+1 
      
    end
    for k,v in pairs(clones) do
        v:update(dt)
    end 
    love.keyboard.keysPressed = {}
end

function love.draw()
    cam:attach()
        gStateMachine:draw()
        player:draw()
        for k,v in pairs(clones) do 
            v:draw()
        end     
        --world:draw()
    cam:detach()
end