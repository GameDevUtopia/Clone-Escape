require 'src/Collision'
sti = require 'lib/sti'
require 'src/Player'
Map1 = Class()
function Map1:init()
    self.map1 = sti('levels/level1.lua')
    player.collider:setY(180)
    player.collider:setX(20)
    self.platforms={}
    self.walls={}
    self.acid={}
    --------------------------------------------------------------
    self.acid_wall = world:newRectangleCollider(346,90,10,18*3)
    self.acid_wall:setType('static')
    self.acid_wall:setCollisionClass('Acid')
    self.acid_wall_img = love.graphics.newImage('assets/Level1/kenney_pixel-platformer-industrial-expansion/Tiles/tile_0031.png')
    self.acid_present =true
    ----------------------------------------------------------------
    self.movPlatform=world:newRectangleCollider(180,126,18*3,10) 
    self.movPlatform:setType('static')
    self.movPlatform:setFixedRotation(true)
    self.movPlatform:setCollisionClass('platform')
    self.movPlatform_img = love.graphics.newImage('assets/platform.png')
    ----------------------------------------------------------------------
    if self.map1.layers['Platform'] then
        for i,obj in pairs(self.map1.layers['Platform'].objects) do
            local  platform = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height) 
            platform:setType('static')
            platform:setCollisionClass('platform')
            table.insert( self.platforms,platform )
        end
    end
    ---------------------------------------------------------------------------
    if self.map1.layers['Wall'] then
        for i,obj in pairs(self.map1.layers['Wall'].objects) do
            
            local  wall = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height) 
            wall:setType('static')
            wall:setCollisionClass('walls')
            table.insert( self.walls,wall )
        end
    end
    -----------------------------------------------------------------------------
    if self.map1.layers['Acid'] then
        for i,obj in pairs(self.map1.layers['Acid'].objects) do
            local  Acid = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height) 
            Acid:setType('static')
            Acid:setCollisionClass('Acid')
            table.insert( self.acid,Acid)
        end
    end
    --------------------------------------------------------------------------------------
   self.vx = 50
   -----------------------------------------------------------------------------
   self.button  = world:newRectangleCollider(336,58,10,10)
   self.button:setType('static')
   self.button:setCollisionClass('button')
   self.button_img1 = love.graphics.newImage('assets/Level1/kenney_pixel-platformer-industrial-expansion/Tiles/tile_0064.png')
   self.button_img2 = love.graphics.newImage('assets/Level1/kenney_pixel-platformer-industrial-expansion/Tiles/tile_0065.png')
   self.button_pressed = false
    ----------------------------------------------------------------------
end
function Map1:update(dt)
    if (self.movPlatform:getX()-18*3<=150 ) then
        self.vx =50
    end
    if (self.acid_present) then
        if (self.movPlatform:getX()+18*3>=342) then
            self.vx =-50
        end
    else 
        if (self.movPlatform:getX()+18*3>=450) then
            self.vx =-50
        end 
    end
    
    if (player.collider:enter('button')) then 
        self.acid_wall:destroy()
        self.acid_present =false
        self.button_pressed = true
        
    elseif (player.collider:exit('button'))then 
        self.acid_wall = world:newRectangleCollider(346,90,10,18*3)
        self.acid_wall:setType('static')
        self.acid_wall:setCollisionClass('Acid')
        self.acid_present = true
        self.button_pressed = false
    end 
    for i,j in pairs(clones) do 
        if (j.clonecollider:enter('button')) then 
            self.acid_wall:destroy()
            self.acid_present =false
        elseif (j.clonecollider:exit('button'))then 
            self.acid_wall = world:newRectangleCollider(346,90,10,18*3)
            self.acid_wall:setType('static')
            self.acid_wall:setCollisionClass('Acid')
            self.acid_present = true
        end 
    end
    
    self.movPlatform:setX(self.movPlatform:getX()+self.vx*dt)
    cam:lookAt(450,140)
   
   
end
function Map1:draw()
    cam:zoomTo(1.45)
    love.graphics.draw(bg,0,0,0,0.5,0.25)
    self.map1:drawLayer(self.map1.layers['Layer1'])
    if(self.acid_present) then
        love.graphics.draw(self.acid_wall_img,346,90,0,0.56,3)
    end    
    love.graphics.draw(self.movPlatform_img,self.movPlatform:getX()-27,self.movPlatform:getY()-5,0,1,0.56)
    if (self.button_pressed) then 
        love.graphics.draw(self.button_img2,330,72,-1.57)
    else
        love.graphics.draw(self.button_img1,330,72,-1.57)
        
    end    

    
end
function Map1:reset()
    player.collider:setX(20)
    player.collider:setY(180)
    self.vx =0
    self.movPlatform:setX(180)
    self.movPlatform:setY(126)
    
    self.acid_present = true
end    