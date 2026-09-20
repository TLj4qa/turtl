local t = turtle

-- table refuelSlots {1, 2, 3...}
function newRefuel(refuelSlots)
  local self = {}
  local fuelType = {"minecraft:coal", "minecraft:charcoal", "minecraft:coalblock", "minecraft:lava_bucket"}
  function self:refuel()
    for _, slot in ipairs(refuelSlots) do
      local detail = t.getItemDetail(slot)
      local getRefuel = false
      if detail ~= nil then
        for _, name in ipairs(fuelType) do
          if (name == detail.name) then
            t.refuel()
            getRefuel = true
            break
          end
        end
      end
      if getRefuel then
        print('im get fuel!')
        break
      end
    end
  end
  return self
end
