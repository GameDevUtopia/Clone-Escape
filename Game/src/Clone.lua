require 'src/Collision'
Clone=Class()
function Clone:init(clonex,cloney,name)
    self.clonex = clonex
    self.cloney = cloney
   
    self.clonecollider=world:newBSGRectangleCollider(self.clonex[1],self.cloney[1],10,16,2)
    self.clonecollider:setFixedRotation(true)
    self.clonecollider:setCollisionClass(name)
    self.i=2
    self.clone_img=love.graphics.newImage("assets/clone.png")
    local grid=anim.newGrid(32,32,self.clone_img:getWidth(),self.clone_img:getHeight())
    self.animations={}
    ----------left-----------------
    self.animations.leftjump=anim.newAnimation(grid('1-8',1),0.01)       
    self.animations.leftrun=anim.newAnimation(grid('1-6',3),0.08)
    self.animations.leftidle=anim.newAnimation(grid('1-4',5),0.2)
    ------------right-------------
    self.animations.rightjump=anim.newAnimation(grid('1-8',6),0.01)
    self.animations.rightidle=anim.newAnimation(grid('1-4',10),0.2)
    self.animations.rightrun=anim.newAnimation(grid('1-6',8),0.08)
   
    self.animation = self.animations.rightidle
    self.pose="right"
end
function Clone:update(dt)
    self.animation:update(dt)
    self.x=self.clonecollider:getX()
    self.y=self.clonecollider:getY()
    if self.i<=#self.clonex then
        self.x=self.clonex[self.i-1]
        self.y=self.cloney[self.i-1]
        if self.clonex[self.i-1]<self.clonex[self.i] then
            self.pose="right"
            self.animation=self.animations.rightrun
            
        elseif self.clonex[self.i]<self.clonex[self.i-1] then
            self.pose="left"
            self.animation=self.animations.leftrun
        else
            if self.pose=="right" then
                self.animation=self.animations.rightidle
            else
                self.animation=self.animations.leftidle
            end
        end
    
        self.clonecollider:setX(self.x)
        -- print(self.clonecollider:getX())
        self.clonecollider:setY(self.y)
        -- print(self.clonecollider:getY())
        self.i=self.i+1 
    end
    
    
end
function Clone:draw()
    self.animation:draw(self.clone_img,self.x,self.y,0,0.8,0.8,16,19)
end