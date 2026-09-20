require("lib.Refuel")
require("lib.ConfigManager")
require("lib.HeightMap")

local dictionaryPath, heightMap = ...
local config = newConfigManager(dictionaryPath)
local heightMapReader = newHeightMapReader(heightMap)

local refuelO = newRefuel({13, 14, 15, 16})
refuelO:refuel()

for symbol in newHeightMapReader.walk() do
  print(symbol)
end