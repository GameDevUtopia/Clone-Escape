Menu = Class()
function Menu:init()
    
    
    self.bg = love.graphics.newImage('assets/mainmenu.png')
end
function Menu:update(dt)
    
    cam:lookAt(640,300)
    if love.keyboard.isDown('return') then
        gStateMachine:change('map0')
    end
end 
function Menu:draw()

    love.graphics.draw(self.bg,0,0,0,2.03,1.5)
    
end   
function Menu:reset( ... )
    -- body
   
    
end
function Menu:exit()
    clones={}
    clonex={}
    cloney={}
end