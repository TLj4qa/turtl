local t = turtle

-- table refuelSlots {1, 2, 3...}
function newRefuel(refuelSlots)
  local self = {}
  local fuelType = {
    "minecraft:coal",
    "minecraft:charcoal",
    "minecraft:coalblock",
    "minecraft:lava_bucket"
  }
  function self:refuel()
    for _, slot in ipairs(refuelSlots) do
      local detail = t.getItemDetail(slot)
      print(detail.name)
      
    end
  end
  return self
end