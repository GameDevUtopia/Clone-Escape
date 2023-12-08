End = Class()
function End:init()
    
    
    self.bg = love.graphics.newImage('assets/GameOver.png')
end
function End:update(dt)
    
    cam:lookAt(640,300)
    if love.keyboard.isDown('return') then
        gStateMachine:change('map0')
    end
end 
function End:draw()

    love.graphics.draw(self.bg,0,0,0,2.03,1.5)
    
end   
function End:reset( ... )
    -- body
   
    
end
function End:exit()
    clones={}
    clonex={}
    cloney={}
end