require("lib.Refuel")
require("lib.ConfigManager")
require("lib.HeightMapReader")
require("lib.TurtleController")

local dictionaryPath, heightMap = ...
local config = newConfigManager(dictionaryPath)
local heightMapReader = newHeightMapReader(heightMap)

local refuelO = newRefuel({13, 14, 15, 16})
refuelO:refuel()

local mapReader = newHeightMapReader(heightMap)
local turtleController = newTurtleController(config)
for symbol in mapReader.walk() do
  turtleController.act(symbol)
end