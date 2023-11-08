require 'src/Collision'
sti = require 'lib/sti'
require 'src/Player'
Map0 =Class()
player=Player(72,68)
function Map0:init()
    self.map0=sti('levels/level0.lua')
    self.timer=0
    self.platforms={}
    self.walls={}
    self.block_img = love.graphics.newImage('assets/Level1/kenney_pixel-platformer-industrial-expansion/Tiles/tile_0009.png')
    self.bg = love.graphics.newImage('assets/Level1/industrial-background.jpg')
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
            local  wall = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height) 
            wall:setType('static')
            wall:setCollisionClass('walls')
            table.insert( self.walls,wall )
        end
    end
    self.block = world:newRectangleCollider(216,126,14,16)
    self.block:setFixedRotation(true)
    -- self.block:setType('dynamic')
    -- self.block:setMass(5)
    self.block:setCollisionClass('block')
end
function Map0:update(dt)
    world:update(dt)
    player:update(dt)
end
function Map0:draw()
    love.graphics.draw(self.bg,0,0,0,0.4,0.4)
    self.map0:drawLayer(self.map0.layers['map'])
    love.graphics.draw(self.block_img,self.block:getX()-10,self.block:getY()-9)
    
end
function Map0:reset()
    player.collider:setX(72)
    player.collider:setY(68)
    self.block:setX(216)
    self.block:setY(126)
end
