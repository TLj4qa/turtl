function newConfigManager(dictionaryPath)
  if dictionaryPath == nil then
    error("dictionary path is required")
  end

  local self = {}
  self.skip = ' '
  self.dictionary = {}
  self.dictionary[' '] = 'minecraft:air'

  local dictFile = fs.open(dictionaryPath, 'r')
  local row = dictFile.readLine()
  while row do
    local key, block = row:match("(%S+)%s+(%S+)")
    self.dictionary[key] = block
    row = dictFile.readLine()
  end
  dictFile.close()

  function self.dictFind(char)
    return self.dictionary[char] or self.dictionary[' ']
  end

  return self
end
