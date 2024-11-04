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

end

return receptors