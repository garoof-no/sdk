local fname
if not web then
  local f
  f = function() return f end
  web = setmetatable({}, { __index = f })
  fname = arg and arg[1]
else
  fname = "input"
  web.file(fname)
  web.title("AoC-25-04")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/3">Advent of Code 2025 - Day 4: Printing Department</a>.</p>]])
end

local f <close> = fname and io.open(fname)

local function solve(lines)
  local res1, res2 = 0, 0
  return res1, res2
end

local examplestr = [[
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
]]

print("with example:")
  print(solve(examplestr:gmatch("[^\n]+")))

if f then
  print("\nwith file input:")
  print(solve(f:lines()))
end

