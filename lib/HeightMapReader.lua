function newHeightMapReader(heightMapFilePath)
  if heightMapFilePath == nil then
    error("height map file path required")
  end

  local self = {}
  function self.walk()
    local file = fs.open(heightMapFilePath, "r")
    return coroutine.wrap(function()
      local row = file.readLine()
      local rightToLeft = false
      while row ~= nil do
        if row == '' then
          coroutine.yield('UP')
        else
          if rightToLeft then
            for i = string.len(row), 1, -1 do
              coroutine.yield(string.sub(row, i, i))
            end
            coroutine.yield('TL')
          else
            for i = 1, string.len(row), 1 do
              coroutine.yield(string.sub(row, i, i))
            end
            coroutine.yield('TR')
          end
        end
        rightToLeft = not rightToLeft
        row = file.readLine()
      end
      file.close()
    end)
  end
  return self
end
