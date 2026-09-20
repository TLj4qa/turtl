function newTurtleController(configManager, turtleNavigator)
  local self = {}
  self.configManager = configManager
  self.navigator = turtleNavigator

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
    self.navigator:forward()
    self.navigator:up()
    self.navigator:turnLeft()
    self.navigator:turnLeft()
  end

  function self.tr()
    self.navigator:forward()
    self.navigator:turnRight()
    self.navigator:forward()
    self.navigator:turnRight()
  end

  function self.tl()
    self.navigator:forward()
    self.navigator:turnLeft()
    self.navigator:forward()
    self.navigator:turnLeft()
  end

  function self.place(command)
    self.navigator:forward()
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
    local currentPosition = self.navigator:getCurrentPosition()
    local currentDirection = self.navigator:getCurrentDirection()
    local backStack = self.goToStock(currentPosition, currentDirection)
    self.recharge()
    self.returnToWork(backStack)
    self.selectNecessary(command, block)
  end

  function self.goToStock(currentPosition, currentDirection)
    local backStack = {}

    while currentDirection ~= 3 do
      self.navigator:turnLeft()
      table.insert(backStack, self.navigator.turnRight)
      currentDirection = self.navigator:getCurrentDirection()
    end

    while currentPosition[1] > 0 do
      self.navigator:forward()
      table.insert(backStack, self.navigator.forward)
      currentPosition[1] = currentPosition[1] - 1
    end

    while currentDirection ~= 4 do
      self.navigator:turnRight()
      table.insert(backStack, self.navigator.turnLeft)
      currentDirection = self.navigator:getCurrentDirection()
    end

    while currentPosition[2] < 0 do
      self.navigator:forward()
      table.insert(backStack, self.navigator.forward)
      currentPosition[2] = currentPosition[2] + 1
    end

    while currentPosition[3] > 0 do
      self.navigator:down()
      table.insert(backStack, self.navigator.up)
      currentPosition[3] = currentPosition[3] - 1
    end

    return backStack
  end

  function self.recharge()

  end

  function self.returnToWork(backStack)
    while #backStack > 0 do
      local action = table.remove(backStack)
      action(self.navigator)
    end
  end

  return self
end
