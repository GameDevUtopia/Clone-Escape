wf = require 'lib/windfield'
world=wf.newWorld(0,500,false) 
world:addCollisionClass('platform')
world:addCollisionClass('block')
world:addCollisionClass('walls')
world:addCollisionClass('player')
world:addCollisionClass('clone1',{ignores={'player'}})
world:addCollisionClass('clone2',{ignores={'player','clone1'}})
world:addCollisionClass('clone3',{ignores={'player','clone1','clone2'}})
world:addCollisionClass('clone4',{ignores={'player','clone1','clone2','clone3'}})
world:addCollisionClass('clone5',{ignores={'player','clone1','clone2','clone3','clone4'}})


