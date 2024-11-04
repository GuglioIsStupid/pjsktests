local slideconnector = class:extend("slideconnector")

function slideconnector:new()
    self._start = {
        time = 1,
        scaledTime = 1
    }

    self._end = {
        time = 2,
        scaledTime = 2
    }

    self._head = {
        time = 1,
        lane = 2,
        scaledTime = 1,
        l = 0,
        r = 2
    }

    self._tail = {
        time = 2,
        lane = 1,
        scaledTime = 2,
        l = 8,
        r = 11
    }

    self.currentTime = -2
end

function lerp(a, b, t)
    return a + (b - a) * t
end

function ease(s, type)
    if type == "In" then
        return s * s  -- In-quad
    elseif type == "Out" then
        return s * (2 - s)  -- Out-quad
    end
    
    return s  -- Linear
end

function unlerpClamped(a, b, t)
    return (t - a) / (b - a)
end

function remap(n, start, stop, newStart, newStop, withinBounds)
    local newStart = newStart or 0
    local newStop = newStop or 1
    local withinBounds = withinBounds or false

    local new = newStart + (newStop - newStart) * ((n - start) / (stop - start))

    if not withinBounds then
        return new
    end

    if newStart < newStop then
        return math.max(math.min(new, newStop), newStart)
    end

    return math.max(math.min(new, newStart), newStop)
end

function slideconnector:getScale(scaledTime)
    return ease(unlerpClamped(self._head.scaledTime, self._tail.scaledTime, scaledTime), "Linear")
end

function approach(from, to, now)
    return 1.06 ^ (45 * remap(now, from, to, -1, 1))
end

function slideconnector:getL(scale)
    return lerp(self._head.l, self._tail.l, scale) - 5
end

function slideconnector:getR(scale)
    return lerp(self._head.r, self._tail.r, scale) - 5
end

function slideconnector:update(dt)
    self.currentTime = self.currentTime + dt
    if self.currentTime > 2 then
        self.currentTime = 0
    end
end

function slideconnector:render()
    local visibleTime = {
        min = math.max(self._head.scaledTime, self.currentTime),
        max = math.min(self._tail.scaledTime, self.currentTime + 1.25)
    }

    if visibleTime.min >= visibleTime.max then
        return
    end

    local w = love.graphics.getWidth()
    local centerX = w / 2  -- Calculate the center of the screen

    for i = 0, 9 do
        local scaledTime = {
            min = lerp(visibleTime.min, visibleTime.max, i / 10),
            max = lerp(visibleTime.min, visibleTime.max, (i + 1) / 10)
        }

        local s = {
            min = self:getScale(scaledTime.min),
            max = self:getScale(scaledTime.max)
        }

        local y = {
            min = approach(scaledTime.min - 1.25, scaledTime.min, self.currentTime),
            max = approach(scaledTime.max - 1.25, scaledTime.max, self.currentTime)
        }

        local layout = {
            x1 = self:getL(s.min) * y.min / 7,
            x2 = self:getL(s.max) * y.max / 7,
            x3 = self:getR(s.max) * y.max / 7,
            x4 = self:getR(s.min) * y.min / 7,

            y1 = y.min,
            y2 = y.max,
            y3 = y.max,
            y4 = y.min
        }

        -- Centering the x-coordinates based on the current y value
        for i2, v in pairs(layout) do
            layout[i2] = layout[i2] * 53
            if i2:sub(1, 1) == "x" then
                layout[i2] = layout[i2] + 60
            end
        end

        love.graphics.push()
            love.graphics.translate(53*10-2, 0)
            love.graphics.polygon('line', layout.x1, layout.y1, layout.x2, layout.y2, layout.x3, layout.y3, layout.x4, layout.y4)
        love.graphics.pop()
    end
end



return slideconnector
