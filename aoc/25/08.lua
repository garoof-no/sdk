local fname
local selfy
if not web then
  selfy = function() return selfy end
  web = setmetatable({}, { __index = selfy })
  fname = arg and arg[1]
else
  fname = "input"
  web.file(fname)
  web.title("AoC-25-08")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/8">Advent of Code 2025 - Day 8: Playground</a>.</p>]])
end

local f <close> = fname and io.open(fname)

vecs = setmetatable({}, { __mode = "v" })
Vec = {}

function vec(x, y, z)
  local key = x .. "," .. y .. "," .. z
  local found = vecs[key]
  if found then return found end
  local v = setmetatable({ x = x, y = y, z = z }, Vec)
  vecs[key] = v
  return v
end

local function distance(a, b)
  local x = math.abs(a.x - b.x)
  local y = math.abs(a.y - b.y)
  local z = math.abs(a.z - b.z)
  return (x * x) + (y * y) + (z * z)
end

local function score(t)
  local a, b, c = 0, 0, 0
  for _, v in ipairs(t) do
    if v > a then c = b ; b = a ; a = v
    elseif v > b then c = b ; b = v
    elseif v > c then c = v end
  end
  return a * b * c
end

local function solve(lines, connections, circuits)
  local boxes, cons, sizes = {}, {}, {}
  local groups = 0
  for line in lines do
    groups = groups + 1
    local x, y, z = line:match("(%d+),(%d+),(%d+)")
    local p = vec(tonumber(x), tonumber(y), tonumber(z))
    local a = { p = p, g = groups }
    for _, b in pairs(boxes) do
      cons[#cons + 1] = { a = a, b = b, d = distance(a.p, b.p) }
    end
    boxes[p] = a
    sizes[groups] = 1
  end
  table.sort(cons, function(a, b) return a.d < b.d end)
  local i = 1
  local c
  local function connect()
    c = cons[i]
    local ag, bg = c.a.g, c.b.g
    if ag ~= bg then
      groups = groups - 1
      for _, v in pairs(boxes) do
        if v.g == bg then v.g = ag end
      end
      sizes[ag] = sizes[ag] + sizes[bg]
      sizes[bg] = 0
    end
    i = i + 1
  end
  for _ = 1, connections do connect() end
  local res1 = score(sizes)
  while groups > 1 do connect() end
  local res2 = c.a.p.x * c.b.p.x
  return res1, res2
end

local examplestr = [[
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
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
  while true do
    for i = 0, 3 do
      for j = 0,3 do
        local fx = math.random(0, 1) == 0 and "x" or ""
        local fy = math.random(0, 1) == 0 and "y" or ""
        web.gfx(i * 64, j, math.random(-1, 241), math.random(0, 141), fx .. fy)
      end
    end
    web.yield(0)
  end
end

