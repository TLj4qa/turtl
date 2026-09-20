local dir = shell.dir()

for _, name in ipairs(fs.list(dir)) do
    fs.delete(fs.combine(dir, name))
end

local dirTree = {"lib"}

for _, dir in ipairs(dirTree) do
  fs.makeDir(dir)
end

local base = "https://raw.githubusercontent.com/TLj4qa/turtl/refs/heads/master/"

local files = {
    {"lib/refuel.lua", "./lib/itemCalculator.lua"},
    {"gitPull.lua", './gitPull.lua'},
    {"main.lua", "./main.lua"}
}

for _, file in ipairs(files) do
  local remote = file[1]
  local localPath = file[2]

  print("Downloading " .. localPath)

  if not shell.run("wget", base .. remote, localPath) then
    printError("Failed: " .. localPath)
    return
  end
end

print("Installation complete")
