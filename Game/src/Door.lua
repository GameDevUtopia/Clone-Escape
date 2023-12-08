require 'src/Collision'

Door = Class()
function Door:init(x,y)
    self.x=x
    self.y =y
    self.door =world:newRectangleCollider(self.x,self.y,18,20)
    self.door:setType('static')
    self.door:setCollisionClass('door')
    self.door_closed = love.graphics.newImage('assets/doorclosed.png')
    self.door_open = love.graphics.newImage('assets/dooropen.png')
    self.closeddoor = true
end   
function Door:update(state) 
    if self.door:enter('player') or self.door:enter('clone') then
        self.closeddoor = false
        gStateMachine:change(state)
    end    
end    
function Door:draw()
    love.graphics.draw(self.door_closed,self.x,self.y)
end    
