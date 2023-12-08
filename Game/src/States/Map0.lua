require 'src/Collision'
sti = require 'lib/sti'
require 'src/Player'
Map0 =Class()

function Map0:init()
    self.door = Door(522,104)    
    player.collider:setX(72)
    player.collider:setY(68)
    self.map0=sti('levels/level0.lua')
    self.timer=0
    self.platforms={}
    self.walls={}
    self.block_img = love.graphics.newImage('assets/Level1/kenney_pixel-platformer-industrial-expansion/Tiles/tile_0009.png')
   
    if self.map0.layers['Platform'] then
        for i,obj in pairs(self.map0.layers['Platform'].objects) do
            local  platform = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height) 
            platform:setType('static')
            platform:setCollisionClass('platform')
            table.insert( self.platforms,platform )
        end
    end
    if self.map0.layers['Wall'] then
        for i,obj in pairs(self.map0.layers['Wall'].objects) do
            print(i)
            local  wall = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height) 
            wall:setType('static')
            wall:setCollisionClass('walls')
            table.insert( self.walls,wall )
        end
    end
    self.block = world:newRectangleCollider(216,126,14,16)
    self.block:setFixedRotation(true)
    self.block:setCollisionClass('block')
    
end
function Map0:update(dt)
    cam:lookAt(270,140)
    self.door:update('map1')
    
end
function Map0:draw()
    cam:zoomTo(2.365)
    love.graphics.draw(bg,0,0,0,0.4,0.4)
    self.map0:drawLayer(self.map0.layers['map'])
    love.graphics.draw(self.block_img,self.block:getX()-10,self.block:getY()-9)
    -- world:draw()
end
function Map0:reset()
    player.collider:setX(72)
    player.collider:setY(68)
    self.block:setX(216)
    self.block:setY(126)
end
function Map0:exit()
    self.block:destroy()
    self.door.door:destroy()
    
    
    i =1
    for i , j in pairs(clones) do
        j.clonecollider:destroy()
    end    
    clones={}
    clonex={}
    cloney={}

    
    for i,j in pairs(self.platforms) do
        j:destroy()
    end
    for i,j in pairs(self.walls) do 
        j:destroy()
    end    
end    

