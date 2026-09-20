function newHeightMapReader(heightMapFilePath)
  if heightMapFilePath == nil then
    error("height map file path required")
  end

  local self = {}
  function self.walk()
    local file = fs.open(heightMapFilePath, "r")
    return coroutine.wrap(function()
      local row = file.readLine()
      local arabian = false
      while row ~= nil do
        if row == '' then
          coroutine.yield('UP')
        else
          if arabian then
            for i = string.len(row), 1, -1 do
              coroutine.yield(string.sub(row, i, i))
            end
          else
            for i = 1, string.len(row), 1 do
              coroutine.yield(string.sub(row, i, i))
            end
          end
          arabian = not arabian
        end
        row = file.readLine()
      end
      file.close()
    end)
  end
end
