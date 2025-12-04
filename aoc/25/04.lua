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
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/4">Advent of Code 2025 - Day 4: Printing Department</a>.</p>]])
end

local f <close> = fname and io.open(fname)

vecs = setmetatable({}, { __mode = "v" })
Vec = {}

web.defpal(0, "31c5")
web.defgfx(0, "00410455106610551554155415541004")
web.defpal(1, "3000")
web.defgfx(1, "00000000000000000000000000000000")
web.defpal(2, "0243")
web.defgfx(2, "65556555aaaa556555655565aaaa6555")
web.legend(".", 1, 1)
web.legend("@", 0, 0)
web.legend("X", 2, 2)

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
  web.newmap()
  local map = {}
  local y = 0
  local w = 1
  for line in lines do
    web.row(line)
    local x = 0
    for c in line:gmatch(".") do
      map[vec(x, y)] = c
      x = x + 1
    end
    w = math.max(w, x)
    y = y + 1
  end
  return map, vec(w, y)
end

local function solve(lines)
  local res1, res2 = 0, 0
  local found = 0
  local map, size = mappy(lines)
  local scale = 8
  while 8 * size.x * scale > 600 and 8 * size.y * scale > 600 do
    scale = scale / 2
  end
  web.scale(scale)
  local skip = size.x * size.y > 500
  
  local function draw(timeout)
    web.clear()
    web.map()
    local y = (size.y * 8) + 8
    web.string("Found: " .. found, 3, 8, y)
    y = y + 8
    web.string("First: " .. res1, 3, 8, y)
    y = y + 8
    web.string("Total: " .. res2, 3, 8, y)
    web.yield(timeout)
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
          found = found + 1
          web.mapset(p.x, p.y, "X")
          if not skip then draw(50) end
        end
      end
    end
    draw(100)
  end

  local function remove(map, first)
    for p, v in pairs(map) do
      if v == "X" then
        map[p] = "."
        found = found - 1
        if first then res1 = res1 + 1 end
        res2 = res2 + 1
        web.mapset(p.x, p.y, ".")
        if not skip then draw(50) end
      end
    end
    draw(100)
  end
  check(map)
  remove(map, true)
  while true do
    local prev = res2
    check(map)
    remove(map)
    if res2 == prev then return res1, res2 end
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

