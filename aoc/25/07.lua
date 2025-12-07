local fname
if not web then
  local f
  f = function() return f end
  web = setmetatable({}, { __index = f })
  fname = arg and arg[1]
else
  fname = "input"
  web.file(fname)
  web.title("AoC-25-07")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/7">Advent of Code 2025 - Day 7: Laboratories</a>.</p>]])
end

local f <close> = fname and io.open(fname)

vecs = setmetatable({}, { __mode = "v" })
Vec = {}

local empty = 0
web.defgfx(empty, "00000000000000000000000000000000")
local cat = 1
web.defgfx(cat, "00410455106610551554155415541004")
local beam = 2
web.defgfx(beam, "15541554155415541554155415541554")
local splitter = 4
web.defgfx(splitter, "15541554555555555415500540010000")
local dark = 0
web.defpal(dark, "0535")
local light = 1
web.defpal(light, "0a35")
local green = 2
web.defpal(green, "3535")
web.legend(".", empty, dark)
web.legend("g", empty, green)
web.legend("S", cat, dark)
web.legend("*", cat, light)
web.legend("|", beam, light)
web.legend("^", splitter, dark)
web.legend("x", splitter, light)

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
local NW, NE, SE, SW = N + W, N + E, S + E, S + W
dirs = { NW, N, NE, E, SE, S, SW, W }

function mappy(lines)
  web.newmap()
  local map = {}
  local start
  local y = 0
  local w = 1
  for line in lines do
    web.row(line)
    local x = 0
    for c in line:gmatch(".") do
      map[vec(x, y)] = c
      if c == "S" then start = vec(x, y) end
      x = x + 1
    end
    w = math.max(w, x)
    y = y + 1
  end
  return map, vec(w, y), start
end

local function solve(lines)
  local res1, res2 = 0, 0
  local found = 0
  local map, size, start = mappy(lines)
  local scale = 8
  while 8 * size.x * scale > 600 and 8 * size.y * scale > 600 do
    scale = scale / 2
  end
  web.scale(scale)
  local skip = size.x * size.y > 500
  local function draw(timeout)
    web.clear(0)
    web.map()
    local y = (size.y * 8)
    web.string("Paths: " .. res2, 2, 0, y)
    y = y + 8
    web.string("Splits: " .. res1, 2, 0, y)
    web.yield(timeout)
  end

  draw(1000)
  local smol = size.x * size.y < 500
  local i = 0
  local results = {}
  local function p2(p)
    if results[p] then return results[p] end
    if p.y >= size.y then
      results[p] = 1
      return 1
    end
    if map[p] == "." then
      local r = p2(p + S)
      results[p] = r
      res2 = "?" .. r .. "?"
      web.mapset(p.x, p.y, "g")
      i = i + 1
      if smol then
        draw(100)
      elseif i == 10 then
        draw(0)
        i = 0
      end
      return r
    end
    if map[p] == "^" then
      local r = p2(p + S + W) + p2(p + S + E)
      results[p] = r
      return r
    end
    print(p, map[p])
    error("???")
  end
  res2 = p2(start + S)

  draw(1000)
  web.mapset(start.x, start.y, "*")
  for y = 1, size.y - 1 do 
    for x = 0, size.x - 1 do
      local p = vec(x, y)
      if map[p + N] == "S" or map[p + N] == "|" then
        if map[p] == "^" then
          web.mapset(p.x, p.y, "x")
          local e = p + E
          map[e] = "|"
          web.mapset(e.x, e.y , "|")
          local w = p + W
          map[w] = "|"
          web.mapset(w.x, w.y, "|")
          res1 = res1 + 1
        else
          map[p] = "|"
          web.mapset(p.x, p.y, "|")
        end
      end
    end
    draw(100)
  end
  draw(1000)
  return res1, res2
end

local examplestr = [[
.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
]]

print("with example:")
print(solve(examplestr:gmatch("[^\n]+")))

if f then
  print("\nwith file input:")
  print(solve(f:lines()))
end

