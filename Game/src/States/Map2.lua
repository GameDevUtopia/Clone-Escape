require 'src/Collision'
sti = require 'lib/sti'
require 'src/Player'
Map2 = Class()
function Map2:init()
    self.map2 = sti('levels/level2.lua')
    player.collider:setY(180)
    player.collider:setX(20)
    self.platforms={}
    self.walls={}
    self.acid={}
    self.firepit =  love.graphics.newImage('assets/flamme.png')
    local grid  = anim.newGrid(16,16,self.firepit:getWidth(),self.firepit:getHeight())
    self.spike = love.graphics.newImage('assets/Spike.png')
    self.fireanim = anim.newAnimation(grid('1-6',1),0.08)
    self.flamecollider = world:newRectangleCollider(93,187,36,12)
    self.flamecollider:setType('static')
    self.flamecollider:setCollisionClass('flame')
    self.door = Door(504,127)
    --------------------------------------------------------------------------
    if self.map2.layers['Platform'] then
        for i,obj in pairs(self.map2.layers['Platform'].objects) do
            local  platform = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height) 
            platform:setType('static')
            platform:setCollisionClass('platform')
            table.insert( self.platforms,platform )
        end
    end
    ---------------------------------------------------------------------------
    if self.map2.layers['Wall'] then
        for i,obj in pairs(self.map2.layers['Wall'].objects) do
            
            local  wall = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height) 
            wall:setType('static')
            wall:setCollisionClass('walls')
            table.insert( self.walls,wall )
        end
    end
    -----------------------------------------------------------------------------
    if self.map2.layers['Acid'] then
        for i,obj in pairs(self.map2.layers['Acid'].objects) do
            local  Acid = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height) 
            Acid:setType('static')
            Acid:setCollisionClass('Acid')
            table.insert( self.acid,Acid)
        end
    end
    if self.map2.layers['Spike1'] then
        local obj = self.map2.layers['Spike1'].objects[1]
        self.spike1x= obj.x
        self.spike1y=obj.y
        self.spike1_width = obj.width
        self.spike1_height = obj.height
       
        self.spike1 = world:newBSGRectangleCollider(obj.x,obj.y,obj.width,obj.height,5)
        self.spike1:setType('static')
        self.spike1:setCollisionClass('spike')

    end
    if self.map2.layers['Spike2'] then
        local obj = self.map2.layers['Spike2'].objects[1]
        self.spike2x= obj.x
        self.spike2y=obj.y
        self.spike2_width = obj.width
        self.spike2_height = obj.height
        self.spike2 = world:newBSGRectangleCollider(obj.x,obj.y,obj.width,obj.height,5)
        self.spike2:setType('static')
        self.spike2:setCollisionClass('spike')

    end
    self.door:update('map0')
    self.button1  = world:newRectangleCollider(90,244,10,10)
    self.button1:setType('static')
    self.button1:setCollisionClass('button1')
    self.button2  = world:newRectangleCollider(185,335,10,10)
    self.button2:setType('static')
    self.button2:setCollisionClass('button2')
    self.button3  = world:newRectangleCollider(361,190,10,10)
    self.button3:setType('static')
    self.button3:setCollisionClass('button3')
    self.button_img1 = love.graphics.newImage('assets/Level1/kenney_pixel-platformer-industrial-expansion/Tiles/tile_0064.png')
    self.button_img2 = love.graphics.newImage('assets/Level1/kenney_pixel-platformer-industrial-expansion/Tiles/tile_0065.png')
    self.button_pressed1 = false
    self.button_pressed2 = false
    self.button_pressed3 = false
    self.button_sfx = love.audio.newSource('sounds/click-button-140881.mp3','stream')
end    
function Map2:update(dt)
    cam:lookAt(270,180)
    self.fireanim:update(dt)
    self.door:update('map0')
    if (player.collider:enter('button1')) then 
        self.flamecollider:destroy()
        self.button_pressed1 = true
        self.button_sfx:play()
        
    elseif (player.collider:exit('button1'))then 
        self.flamecollider = world:newRectangleCollider(93,187,36,12)
        self.flamecollider:setType('static')
        self.flamecollider:setCollisionClass('flame')
        self.button_pressed1 = false
    end 
    for i,j in pairs(clones) do 
        if (j.clonecollider:enter('button1')) then 
            self.flamecollider:destroy()
            self.button_pressed1 = true
            self.button_sfx:play()
        elseif (j.clonecollider:exit('button1'))then 
            self.flamecollider = world:newRectangleCollider(93,187,36,12)
            self.flamecollider:setType('static')
            self.flamecollider:setCollisionClass('flame')
            self.button_pressed1 = false
        end
        if (j.clonecollider:enter('button2')) then 
            self.spike1:destroy()
            self.button_pressed2 = true
            self.button_sfx:play()
            
        elseif (j.clonecollider:exit('button2'))then 
                
            self.spike1 = world:newBSGRectangleCollider(self.spike1x,self.spike1y,self.spike1_width,self.spike1_height,5)
            self.spike1:setType('static')
            self.spike1:setCollisionClass('spike')
            self.button_pressed2 = false
        end 
        if (j.clonecollider:enter('button3')) then 
            self.spike2:destroy()
            self.button_pressed3 = true
            self.button_sfx:play()
            
        elseif (j.clonecollider:exit('button3'))then 
           
            self.spike2 = world:newBSGRectangleCollider(self.spike2x,self.spike2y,self.spike2_width,self.spike2_height,5)
            self.spike2:setType('static')
            self.spike2:setCollisionClass('spike')
            self.button_pressed3 = false
        end 
    end
    if (player.collider:enter('button2')) then 
        self.spike1:destroy()
        self.button_pressed2 = true
        self.button_sfx:play()
        
    elseif (player.collider:exit('button2'))then 
        
        self.spike1 = world:newBSGRectangleCollider(self.spike1x,self.spike1y,self.spike1_width,self.spike1_height,5)
        self.spike1:setType('static')
        self.spike1:setCollisionClass('spike')
        self.button_pressed2 = false
    end 
    if (player.collider:enter('button3')) then 
        self.spike2:destroy()
        self.button_pressed3 = true
        self.button_sfx:play()
        
    elseif (player.collider:exit('button3'))then 
        self.spike2 = world:newBSGRectangleCollider(self.spike2x,self.spike2y,self.spike2_width,self.spike2_height,5)
        self.spike2:setType('static')
        self.spike2:setCollisionClass('spike')
        self.button_pressed3 = false
    end 
    
end
function Map2:draw()
    cam:zoomTo(1.75)
    self.map2:drawLayer(self.map2.layers['bg'])
    self.map2:drawLayer(self.map2.layers['Layer1'])
    self.map2:drawLayer(self.map2.layers['Layer2'])
    if (self.button_pressed1 == false) then
        love.graphics.draw(self.button_img1,86,234)
        self.fireanim:draw(self.firepit,91,184)
        self.fireanim:draw(self.firepit,99,184)
        self.fireanim:draw(self.firepit,107,184)
        self.fireanim:draw(self.firepit,115,184)
    elseif (self.button_pressed1) then
        love.graphics.draw(self.button_img2,86,234)
    end 
    if (self.button_pressed2 == false) then
        love.graphics.draw(self.button_img1,181,325)
        love.graphics.draw(self.spike,254,184)
        love.graphics.draw(self.spike,272,184)
        love.graphics.draw(self.spike,290,184)
        love.graphics.draw(self.spike,308,184)
        love.graphics.draw(self.spike,326,184)
    elseif (self.button_pressed2) then
        love.graphics.draw(self.button_img2,181,325)
    end
    if (self.button_pressed3 == false) then  
        love.graphics.draw(self.button_img1,357,180)  
        love.graphics.draw(self.spike,377,142,3.14)
        love.graphics.draw(self.spike,395,142,3.14)
        love.graphics.draw(self.spike,413,142,3.14)
    elseif (self.button_pressed3) then
        love.graphics.draw(self.button_img2,357,180) 
    end    
    self.door:draw()
end
function Map2:reset()
    player.collider:setX(20)
    player.collider:setY(180)
    self.button_pressed1 =false
    self.button_pressed2 =false
    self.button_pressed3 =false  
end
function Map2:exit()
    
    self.door.door:destroy()
    
    self.button1:destroy()
    self.button2:destroy()
    self.button3:destroy()
    self.spike1:destroy()
    self.spike2:destroy()
    i =1
    for i , j in pairs(clones) do
        j.clonecollider:destroy()
    end    
    clones={}
    clonex={}
    cloney={}
    for i,j in pairs(self.acid) do
        j:destroy()
    end
    for i,j in pairs(self.platforms) do
        j:destroy()
    end
    for i,j in pairs(self.walls) do 
        j:destroy()
    end    
end   