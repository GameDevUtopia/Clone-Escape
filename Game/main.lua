require 'src/Dependencies'

window_width=1280
window_height=600
cam = camera()

clones={}
clonex={}
cloney={}
i=1


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
    map0=Map0()
    
end

function love.update(dt)
    map0:update(dt)
    cam:lookAt(270,140)
    if love.keyboard.isDown('t')  then
        table.insert(clonex,player.collider:getX())
        table.insert(cloney,player.collider:getY())
    end
    
    if love.keyboard.wasPressed('c') and i <=5  then           --and not (love.keyboard.wasPressed('d') or love.keyboard.wasPressed('a') or love.keyboard.wasPressed('space')) then 
        
        obj=Clone(clonex,cloney,'clone'..tostring(i))
        print(type(obj))
        table.insert(clones,obj)
        clonex={} 
        cloney={}
        map0:reset()
        i=i+1 
      
    end
    for k,v in pairs(clones) do
        v:update(dt)
    end 
    love.keyboard.keysPressed = {}
    
end

function love.draw()
    cam:attach()
        cam:zoomTo(2.365)
        map0:draw()
        player:draw()
        for k,v in pairs(clones) do 
            v:draw()
        end
       
        
        -- world:draw()
    cam:detach()
    
end