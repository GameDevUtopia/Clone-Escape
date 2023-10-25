require 'src/Dependencies'
window_width=1280
window_height=720

player=Player()

function love.load()
   
    love.window.setMode(window_width,window_height)
    
    player:init(100,500)

end
function love.update(dt)
    player:update(dt)
end
function love.draw()
   
    player:draw()
   
end