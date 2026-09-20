--    4
-- 3     1
--    2
function newTurtleNavigator(tort)
  local self = {}
  self.position = {0, 0, 0}
  self.direction = 1
  local directionModifier = {1, -1, -1, 1}
  function self:getCurrentPosition()

  end

  function self:turnLeft()
    tort.turnLeft()
    if self.direction == 1 then
      self.direction = 5
    end
    self.direction = self.direction - 1
  end

  function self:turnRight()
    tort.turnRight()
    if self.direction == 4 then
      self.direction = 0
    end
    self.direction = self.direction + 1
  end

  function self:up()
    tort.up()
    self.position[3] = self.position[3] + 1
  end

  function self:down()
    tort.down()
    self.position[3] = self.position[3] - 1
  end

  function self:forward()
    tort.forward()
    if self.direction % 2 == 1 then
      self.position[1] = self.position[1] + directionModifier[self.direction]
    else
      self.position[2] = self.position[2] + directionModifier[self.direction]
    end
  end

  function self:getCurrentPosition()
    return {
        self.position[1],
        self.position[2],
        self.position[3]
    }
  end

  function self:getCurrentDirection()
    return self.direction
  end
  return self
end
