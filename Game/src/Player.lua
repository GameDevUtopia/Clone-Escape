require 'src/Collision'
Player=Class()

function Player:init(playerx,playery)
    
    
    self.collider = world:newBSGRectangleCollider(playerx,playery,10,16,2)
    self.collider:setFixedRotation(true)
    
    self.collider:setCollisionClass('player')
    self.playerspeed=100
    self.footstep_sfx = love.audio.newSource('sounds/FootStep.wav','stream')
    self.jump_sfx= love.audio.newSource('sounds/toy-button-105724.mp3','stream')
    --------------------------Animation--------------------------------------
    self.player_img=love.graphics.newImage("assets/player_img.png")
    local grid=anim.newGrid(32,32,self.player_img:getWidth(),self.player_img:getHeight())
    self.animations={}
    ----------left-----------------
    self.animations.leftjump=anim.newAnimation(grid('1-8',1),0.2)       
    self.animations.leftrun=anim.newAnimation(grid('1-6',3),0.08)
    self.animations.leftidle=anim.newAnimation(grid('1-4',5),0.2)
    self.animations.leftpush=anim.newAnimation(grid('1-4',2),0.2)
    ------------right-------------
    self.animations.rightjump=anim.newAnimation(grid('1-8',6),0.2)
    self.animations.rightrun=anim.newAnimation(grid('1-6',8),0.08)
    self.animations.rightidle=anim.newAnimation(grid('1-4',10),0.2)
    self.animations.rightpush=anim.newAnimation(grid('1-6',7),0.08)
    ---------------------------------------------------------------------
    self.animation = self.animations.rightidle
    self.pose="right" --Determines Pose of thr player
    self.onground=false
    self.ismoving = false
   
end
    
function Player:update(dt)
   self.animation:update(dt)
   self.x=self.collider:getX()
   self.y=self.collider:getY()
   self.vx,self.vy=self.collider:getLinearVelocity()
   
   if self.collider:enter('platform') or self.collider:enter('block') then  ------Checks if player is on ground
        self.onground=true
        
   end
--    print(self.onground)
  ------------------------------Movement---------------------------------
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.vx=self.playerspeed*-1
        self.collider:setLinearVelocity(self.vx,self.vy)
        self.animation=self.animations.leftrun
        self.pose="left"
        self.ismoving = true
        
    else
        if self.pose=="left" then
            self.vx=0
            self.collider:setLinearVelocity(self.vx,self.vy)
            self.animation=self.animations.leftidle
            self.ismoving = false
        end
    end

    if love.keyboard.isDown('d') or love.keyboard.isDown('right')then
        self.vx=self.playerspeed
        self.collider:setLinearVelocity(self.vx,self.vy)
        self.animation=self.animations.rightrun
        self.pose="right"
        self.ismoving = true

    else
        if self.pose=="right" then 
            self.vx=0
            self.collider:setLinearVelocity(self.vx,self.vy)
            self.animation=self.animations.rightidle
            self.ismoving = false
        end
    end
 
    
    if (love.keyboard.wasPressed('space') or love.keyboard.wasPressed('w') or love.keyboard.wasPressed('up') ) and self.onground  then
        self.collider:applyLinearImpulse(0,-75)
        self.onground=false
        self.jump_sfx:play()
        
    end
    if (self.collider:enter('Acid') or self.collider:enter('spike') or self.collider:enter('flame') ) then
        gStateMachine:change('end')

    end   

    -- print(self.onground)
 --------------------------------------------------------------------------------       
    -- if self.ismoving and self.onground then
    --     self.footstep_sfx:play()
    -- end
   
    
   
end

function Player:draw()
    self.animation:draw(self.player_img,self.x,self.y,0,0.8,0.8,16,19)
end