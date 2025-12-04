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

vecs = setmetatable({}, { __mode = "v" })
Vec = {}

function vec(x, y)
  local key = x .. "," .. y
  local found = vecs[key]
  if found then return found end
  local v = setmetatable({ x = x, y = y}, Vec)
  vecs[key] = v
  return v
end

function Vec.__add(a, b) return vec(a.x + b.x, a.y + b.y) end
function Vec.__tostring(a) return a.x .. "," .. a.y end

local N, E, S, W = vec(0, -1), vec(1, 0), vec(0, 1), vec(-1, 0)
N.name = "N" ; E.name = "E" ; S.name = "S" ; W.name = "W"
local NW, NE, SE, SW = N + W, N + E, S + E, S + W
NW.name = "NW" ; NE.name = "NE" ; SE.name = "SE" ; SW.name = "SW"
dirs = { NW, N, NE, E, SE, S, SW, W }

function mappy(lines)
  local map = {}
  local w = 1
  local y = 0
  for line in lines do
    y = y + 1
    local x = 0
    for c in line:gmatch(".") do
      x = x + 1
      map[vec(x, y)] = c
    end
    w = math.max(w, x)
  end
  return map, vec(w, y)
end

function printmap(map, size)
  print(size)
  for y = 1, size.y do
    for x = 1, size.x do
      io.write(map[vec(x, y)] or " ")
    end
    io.write("\n")
  end
end

local function neighbours(map, p)
  local res = {}
  for _, d in ipairs(dirs) do
    local newp = p + d
    if map[newp] == "@" or map[newp] == "X" then res[#res + 1] = p end
  end
  return res
end

local function check(map)
  for p, v in pairs(map) do
    if v == "@" then
      local n = neighbours(map, p)
      if #n < 4 then
        map[p] = "X"
      end
    end
  end
end

local function remove(map)
  local res = 0 
  for p, v in pairs(map) do
    if v == "X" then
      map[p] = "."
      res = res + 1
    end
  end
  return res
end

local function solve(lines)
  local map, size = mappy(lines)
  local res1, res2
  check(map)
  res1 = remove(map)
  res2 = res1
  print(res1)
  while true do
    local r
    check(map)
    r = remove(map)
    res2 = res2 + r 
    if r == 0 then return res1, res2 end
  end
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

