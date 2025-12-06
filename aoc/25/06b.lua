local selfy
if not web then
  selfy = function() return selfy end
  web = setmetatable({}, { __index = selfy })
else
  web.file(fname)
  web.title("AoC-25-06")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/6">Advent of Code 2025 - Day 6: Trash Compactor</a>.</p>]])
end

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

function mappy(lines)
  web.newmap()
  local map = {}
  local y = 0
  local w = 1
  for line in lines do
    web.row(line)
    local x = 0
    for c in line:gmatch(".") do
      if c ~= " " then
        local p = vec(x, y)
        map[p] = { c = c, p = p, t = nil }
      end
      x = x + 1
    end
    w = math.max(w, x)
    y = y + 1
  end
  return map, vec(w, y)
end

local function solve(lines)
  local res = 0
  local found = 0
  local map, size = mappy(lines)
  local len = math.max(size.x, size.y)
  local scale = 8
  while 8 * scale * len > 600 do
    scale = scale / 2
  end
  web.scale(scale)
  local down = len * 8 - size.y * 8
  for _, c in pairs(map) do
    local p = c.p
    c.p = vec(p.x * 8, down + p.y * 8)
    c.t = vec(p.y * 8, len * 8 - p.x * 8)
  end
  web.clear()
  for _, c in pairs(map) do
    web.string(c.c, 0, c.p.x, c.p.y)
  end
  web.yield(1000)
  while true do
    web.clear()
    local moved = false
    for _, c in pairs(map) do
      local xs, ys = 0, 0
      if (c.p.x > c.t.x) then
        moved = true
        xs = -1
      elseif (c.p.x < c.t.x) then
        moved = true
        xs = 1
      end
      if (c.p.y > c.t.y) then
        moved = true
        ys = -1
      elseif (c.p.y < c.t.y) then
        moved = true
        ys = 1
      end
      c.p = vec(c.p.x + xs, c.p.y + ys)
      web.string(c.c, 0, c.p.x, c.p.y)
    end
    if not moved then return end
    web.yield(100)
  end
end

local examplestr = [[
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
]]

solve(examplestr:gmatch("[^\n]+"))

