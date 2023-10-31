require 'src/Dependencies'

window_width=1280
window_height=720


clones={}
clonex={}
cloney={}
i=1

player=Player(250,600)
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
    love.window.setMode(window_width,window_height)
    love.keyboard.keysPressed = {}
    
end

function love.update(dt)
    world:update(dt)
    player:update(dt)
    table.insert(clonex,player.collider:getX())
    table.insert(cloney,player.collider:getY())
    
    if love.keyboard.wasPressed('c') and i <=5 then 
        obj=Clone(clonex,cloney,'clone'..tostring(i))
        print(type(obj))
        table.insert(clones,obj)
        clonex={} 
        cloney={}
        player.collider:setX(250)
        player.collider:setY(600)
        i=i+1 
      
    end
    for k,v in pairs(clones) do
        v:update(dt)
    end 
    love.keyboard.keysPressed = {}
    
end

function love.draw()
   
    player:draw()
    -- world:draw()
    for k,v in pairs(clones) do 
        v:draw()
    end
    
end