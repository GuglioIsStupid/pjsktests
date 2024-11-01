class = require 'class'
local tracenote = require 'slideconnector'
local receptors = (require 'receptors')()

local test = tracenote()

function love.load()
end

function love.update(dt)
    test:update(dt)
end

function love.draw()
    test:render()
    receptors:render()
end