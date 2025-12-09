local fname
local selfy
if not web then
  selfy = function() return selfy end
  web = setmetatable({}, { __index = selfy })
  fname = arg and arg[1]
else
  fname = "input"
  web.file(fname)
  web.title("AoC-25-09")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/9">Advent of Code 2025 - Day 9: Movie Theater</a>.</p>]])
end

local f <close> = fname and io.open(fname)

local vecs = setmetatable({}, { __mode = "v" })
local Vec = {}
function Vec.__tostring(a) return a.x .. "," .. a.y end

local function vec(x, y)
  local key = x .. "," .. y
  local found = vecs[key]
  if found then return found end
  local v = setmetatable({ x = x, y = y, z = z }, Vec)
  vecs[key] = v
  return v
end

local function area(a, b)
  local x = 1 + math.abs(a.x - b.x)
  local y = 1 + math.abs(a.y - b.y)
  return x * y
end

local function line(a, b)
  if a.x == b.x then
    return { x = a.x, y1 = math.min(a.y, b.y), y2 = math.max(a.y, b.y) }
  elseif a.y == b.y then
    return { y = a.y, x1 = math.min(a.x, b.x), x2 = math.max(a.x, b.x) }
  else error("line from " .. tostring(a) .. " to " .. tostring(b))
  end
end

local function nope(x, min, max, ax, ay, bx, by)
  if x <= ax or x >= bx then return false end
  if min >= by or max <= ay then return false end
  return true
end

local function solve(input, connections, circuits)
  local tiles, areas, lines = {}, {}, {}
  local n = 0
  for str in input do
    n = n + 1
    local x, y = str:match("(%d+),(%d+)")
    local a = vec(tonumber(x), tonumber(y))
    for _, b in pairs(tiles) do
      areas[#areas + 1] = {
        a = vec(math.min(a.x, b.x), math.min(a.y, b.y)),
        b = vec(math.max(a.x, b.x), math.max(a.y, b.y)),
        area = area(a, b)
      }
    end
    tiles[n] = a
  end
  for i = 1, #tiles - 1 do
    lines[i] = line(tiles[i], tiles[i + 1])
  end
  lines[#lines + 1] = line(tiles[#tiles], tiles[1])
  table.sort(areas, function(a, b) return a.area > b.area end)
  local res1 = areas[1].area
  local function okay(a)
    for _, l in ipairs(lines) do
      if l.x and nope(l.x, l.y1, l.y2, a.a.x, a.a.y, a.b.x, a.b.y) then return false end
      if l.y and nope(l.y, l.x1, l.x2, a.a.y, a.a.x, a.b.y, a.b.x) then return false end
    end
    return true
  end
  okay(areas[1])
  
  for _, a in ipairs(areas) do
    if okay(a) then return res1, a.area end
  end

  return res1
end

local examplestr = [[
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
]]

print("with example:")
print(solve(examplestr:gmatch("[^\n]+"), 10))

if f then
  print("\nwith file input:")
  print(solve(f:lines(), 1000))
end


if not selfy then
  local h = "0123456789abcdef"
  for i = 0, 3 do
    web.defgfx(i * 64, "00410455106610551554155415541004")
  end
  for i = 0, 15 do
    local fur = h:sub(i + 1, i + 1)
    local j = (i + 1) % 16
    web.defpal(i,  fur .. fur .. h:sub(j + 1) .. 0)
  end
  local cats = {}
  for _ = 1, 16 do
    for i = 0, 3 do
      for j = 0,3 do
        cats[#cats + 1] = { s = i * 64, p = j }
      end
    end
  end

  local function shoot(c)
    c.x = 96
    c.y = 150
    c.sx = math.random(-5, 5)
    c.sy = math.random(-20, -10)
    local fx = math.random(0, 1) == 0 and "x" or ""
    local fy = math.random(0, 1) == 0 and "y" or ""
    c.f = fx .. fy
  end
  for _, c in ipairs(cats) do shoot(c) end

  while true do
    web.clear()
    for _, c in ipairs(cats) do
      if c.y > 150 then
        shoot(c)
      else
        c.x = c.x + c.sx
        c.y = c.y + c.sy
        c.sy = c.sy + 1
      end
      web.gfx(c.s, c.p, c.x, c.y, c.f)
    end
    web.yield(25)
  end
end

