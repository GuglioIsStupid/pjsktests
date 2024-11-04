local tapnote = class:extend("tapnote")

function tapnote:new()
    self.height = 25

    self.currentTime = 0

    self.visualtime = {
        max = 1,
    }
    self.visualtime.min = self.visualtime.max - 1.25

    self.l = 0
    self.r = 2

    self.h = 75 / 720 / 2
    self.b = 1 + self.h
    self.t = 1 - self.h

    local ml = self.l + 0.3
    local mr = self.r - 0.3
    self.quads = {
        left = perspectiveLayout(self.l-2, ml-2, self.b, self.t),
        middle = perspectiveLayout(ml-2, mr-2, self.b, self.t),
        right = perspectiveLayout(mr-2, self.r-2, self.b, self.t),
    }
end

function tapnote:update(dt)
end

function tapnote:getScale(time)
end

function tapnote:render()
    local y = approach(self.visualtime.min, self.visualtime.max, currentTime)

    love.graphics.setColor(1, 1, 1)
    love.graphics.push()
    love.graphics.translate(53*10+50, 0)
    -- the quads are polygons with x1-4 and y1-4
    for _, quad in pairs(self.quads) do
        if _ ~= "middle" then
            love.graphics.setColor(1, 0, 0)
        else
            love.graphics.setColor(0, 1, 0)
        end

        --
        love.graphics.polygon("line",
            quad.x1 * y/4.8, quad.y1 * y,
            quad.x2 * y/4.8, quad.y2 * y,
            quad.x3 * y/4.8, quad.y3 * y,
            quad.x4 * y/4.8, quad.y4 * y
        )
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.pop()
end

return tapnote