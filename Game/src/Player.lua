require 'src/Collision'
Player=Class()

function Player:init(playerx,playery,player_onground)
    
    
    self.collider = world:newBSGRectangleCollider(playerx,playery,18,29,10)
    self.collider:setFixedRotation(true)
    
    self.collider:setCollisionClass('player')
    self.playerspeed=100
    
    --------Animation-------------
    self.player_img=love.graphics.newImage("assets/player_img.png")
    local grid=anim.newGrid(32,32,self.player_img:getWidth(),self.player_img:getHeight())
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
    self.onground=false
    -- function custom_collision(collider_1,collider_2,contact)
    --     if collider_1.collision_class == 'player' and collider_2.collision_class == 'platform' then
    --         self.onground=true
    --     end
    -- end
    -- self.collider:setPreSolve(custom_collision)
end
    
function Player:update(dt)
   self.animation:update(dt)
   self.x=self.collider:getX()
   self.y=self.collider:getY()
   self.vx,self.vy=self.collider:getLinearVelocity()
   if self.collider:enter('platform') then 
        self.onground=true
   end
--    print(self.onground)
  
    if love.keyboard.isDown('a') then
        self.vx=self.playerspeed*-1
        self.collider:setLinearVelocity(self.vx,self.vy)
        self.animation=self.animations.leftrun
        self.pose="left"
    else
        if self.pose=="left" then
            self.vx=0
            self.collider:setLinearVelocity(self.vx,self.vy)
            self.animation=self.animations.leftidle
        end
    end

    if love.keyboard.isDown('d') then
        self.vx=self.playerspeed
        self.collider:setLinearVelocity(self.vx,self.vy)
        self.animation=self.animations.rightrun
        self.pose="right"
    else
        if self.pose=="right" then 
            self.vx=0
            self.collider:setLinearVelocity(self.vx,self.vy)
            self.animation=self.animations.rightidle
        end
    end
 
    
    if love.keyboard.wasPressed('space') and self.onground  then
        self.collider:applyLinearImpulse(0,-500)
        self.onground=false
      
    end
    -- print(self.onground)
       

   
    
   
end

function Player:draw()
    self.animation:draw(self.player_img,self.x,self.y,0,0.5625,0.5625,16,19)
end