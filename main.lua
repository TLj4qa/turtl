require("lib.Refuel")
require("lib.ConfigManager")
require("lib.HeightMapReader")

local dictionaryPath, heightMap = ...
local config = newConfigManager(dictionaryPath)
local heightMapReader = newHeightMapReader(heightMap)

local refuelO = newRefuel({13, 14, 15, 16})
refuelO:refuel()

local mapReader = newHeightMapReader(heightMap)
for symbol in mapReader.walk() do
  print(symbol)
end