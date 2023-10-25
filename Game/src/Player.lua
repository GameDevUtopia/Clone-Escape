Player=Class{}
function Player:init(playerx,playery)
    
    self.playerx=playerx
    self.playery=playery
    self.player_img=love.graphics.newImage("assets/player_img.png")
    local grid=anim.newGrid(32,32,self.player_img:getWidth(),self.player_img:getHeight())
    self.animations={}

    self.animations.leftjump=anim.newAnimation(grid('1-8',1),0.08)
    self.animations.rightjump=anim.newAnimation(grid('1-8',6),0.08)
    self.animations.leftidle=anim.newAnimation(grid('1-4',5),0.2)
    self.animations.rightidle=anim.newAnimation(grid('1-4',10),0.2)

    -- self.animations.uprun=anim.newAnimation(grid('1-6',9),0.08)
    -- self.animations.downrun=anim.newAnimation(grid('1-6',3),0.08)
    self.animations.leftrun=anim.newAnimation(grid('1-6',3),0.08)
    self.animations.rightrun=anim.newAnimation(grid('1-6',8),0.08)
   
    self.animation = self.animations.rightidle
    self.pose="right"
end

function Player:update(dt)
   self.animation:update(dt)
    
    
    if love.keyboard.isDown('a') then
        self.playerx=self.playerx-100*dt
        self.animation=self.animations.leftrun
        self.pose="left"
    else
        if self.pose=="left" then
            self.animation=self.animations.leftidle
        end
    end

    if love.keyboard.isDown('d') then
        self.playerx=self.playerx+100*dt
        self.animation=self.animations.rightrun
        self.pose="right"
    else
        if self.pose=="right" then 
            self.animation=self.animations.rightidle
        end
    end
    if love.keyboard.isDown('space') then
        if self.pose=="right" then  
            self.animation=self.animations.rightjump
        else
            self.animation=self.animations.leftjump
        end
    end

end

function Player:draw()
    self.animation:draw(self.player_img,self.playerx,self.playery,0,2,2)
end