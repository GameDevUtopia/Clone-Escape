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
    love.window.setMode(window_width,window_height)
    love.keyboard.keysPressed = {}
    --map0=Map0()
   map1=Map1()
   
    
end

function love.update(dt)
    player:update(dt)
    map1:update(dt)
    world:update(dt)
   --map0:update(dt)
    if love.keyboard.isDown('t')  then
        table.insert(clonex,player.collider:getX())
        table.insert(cloney,player.collider:getY())
    end
    
    if love.keyboard.wasPressed('c') and i <=5  then          
        
        obj=Clone(clonex,cloney,'clone'..tostring(i))
        print(type(obj))
        table.insert(clones,obj)
        clonex={} 
        cloney={}
        map1:reset()
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
        --map0:draw()
        map1:draw()
        player:draw()
    
        for k,v in pairs(clones) do 
            v:draw()
        end
       
        
     -- world:draw()
    cam:detach()
    
end