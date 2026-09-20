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
          row = file.readLine()
        else
          if rightToLeft then
            for i = string.len(row), 1, -1 do
              coroutine.yield(string.sub(row, i, i))
            end
            row = file.readLine()
            if row ~= '' then
              coroutine.yield('TL')
            end
          else
            for i = 1, string.len(row), 1 do
              coroutine.yield(string.sub(row, i, i))
            end
            if row ~= '' then
              row = file.readLine()
            end
            coroutine.yield('TR')
          end
        end
        rightToLeft = not rightToLeft

      end
      file.close()
    end)
  end
  return self
end
