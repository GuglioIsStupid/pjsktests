local receptors = class:extend("receptors")

-- receptors 0-11

function receptors:new()
    self.receptors = {}
    for i = 0, 11 do
        self.receptors[i] = {
            time = 0,
            scaledTime = 0,
            lane = i,
            l = i,
            r = i+1,
        }
    end
end

function receptors:update(dt)
    for i = 0, 11 do
        self.receptors[i].time = self.receptors[i].time + dt
        self.receptors[i].scaledTime = self.receptors[i].time
    end
end

function receptors:render()
    for i = 0, 11 do
        love.graphics.setColor(1, 1, 1)

        local layout = {
            x1 = self.receptors[i].l * (48*2)+60,
            x2 = self.receptors[i].r * (48*2)+60,
            y1 = love.graphics.getHeight() - 53,
            y2 = love.graphics.getHeight()
        }


        print("X", layout.x1, "Y", layout.y1, "W", layout.x2 - layout.x1, "H", layout.y2 - layout.y1)
        love.graphics.rectangle("line", layout.x1, layout.y1, layout.x2 - layout.x1, layout.y2 - layout.y1)
    end
end

return receptors