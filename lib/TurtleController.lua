function newTurtleController(configManager)
  local self = {}
  self.configManager = configManager

  function self.act(command)
    if command == 'UP' then
      self.up()
    elseif command == 'TL' then
      self.tl()
    elseif command == 'TR' then
      self.tr()
    else
      self.place(command)
    end
  end

  function self.up()
    turtle.forward()
    turtle.up()
    turtle.turnLeft()
    turtle.turnLeft()
  end

  function self.tr()
    turtle.forward()
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
  end

  function self.tl()
    turtle.forward()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
  end

  function self.place(command)
    turtle.forward()
    local block = self.configManager.dictFind(command)
    if block == 'minecraft:air' then
      return
    end
    local itemDetail = turtle.getItemDetail(turtle.getSelectedSlot())
    if itemDetail == nil or itemDetail.name ~= block then
      self.selectNecessary(command, block)
    end
    turtle.placeDown()
  end

  function self.selectNecessary(command, block)
    for i = 1, 16, 1 do
      turtle.select(i)
      local itemDetail = turtle.getItemDetail(turtle.getSelectedSlot())
      if itemDetail ~= nil and itemDetail.name == block then
        return
      end
    end
    error('block is not found')
  end
  return self
end
