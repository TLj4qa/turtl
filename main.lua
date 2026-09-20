require("lib.Refuel")
require("lib.ConfigManager")
require("lib.HeightMapReader")
require("lib.TurtleController")
require("lib.TurtleNavigator")

local dictionaryPath, heightMap = ...

-- Prepare map!
local map = fs.open(heightMap, 'r')
local tmpMap = fs.open("tmp.map", 'w')
local page = {}
local upsideDown = false
for str in map.readLine do
  if str == '' then
    if upsideDown then
      for i = #page, 1, -1 do
        tmpMap.writeLine(string.reverse(page[i]))
      end
    else
      for i = 1, #page, 1 do
        tmpMap.writeLine(page[i])
      end
    end
    tmpMap.writeLine('')
    page = {}
    upsideDown = not upsideDown
  else
    table.insert(page, str)
  end
end

map.close()
tmpMap.close()

local config = newConfigManager(dictionaryPath)

local refuelO = newRefuel({13, 14, 15, 16})
refuelO:refuel()
local navigator = newTurtleNavigator()

local mapReader = newHeightMapReader('tmp.map')
local turtleController = newTurtleController(config, navigator)
for symbol in mapReader.walk() do
  turtleController.act(symbol)
end