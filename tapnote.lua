local tapnote = class:extend("tapnote")

function tapnote:new()
    self.height = 25

    self.currentTime = 0

    self.visualtime = {
        min = 0.5,
    }
    self.visualtime.max = self.visualtime.min + 1.25

    self.l = 1
    self.r = 2

    self.b = 1 + 10
    self.t = 1 - 10
end

function tapnote:update(dt)
    self.currentTime = self.currentTime + dt
    if self.currentTime > 2 then
        self.currentTime = 0
    end
end

function tapnote:getScale(time)
end

function tapnote:render()
    local y = approach(self.visualtime.min, self.visualtime.max, self.currentTime)

    love.graphics.setColor(1, 1, 1)
    love.graphics.push()
    

    love.graphics.setColor(1, 1, 1)
    love.graphics.pop()
end

return tapnote