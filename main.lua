function perspectiveLayout(l, r, b, t)
    return {
        x1 = l * b,
        x2 = l * t,
        x3 = r * t,
        x4 = r * b,
        y1 = b,
        y2 = t,
        y3 = t,
        y4 = b,
    }
end

class = require 'class'
local tracenote = require 'slideconnector'
local tapnote = require 'tapnote'
local receptors = (require 'receptors')()

local test = tracenote()
local testtap = tapnote()

function love.load()
end

function love.update(dt)
    test:update(dt)
    testtap:update(dt)
end

function love.draw()
    test:render()
    testtap:render()
    receptors:render()
end