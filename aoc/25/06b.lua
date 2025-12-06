local selfy
if not web then
  selfy = function() return selfy end
  web = setmetatable({}, { __index = selfy })
else
  web.file(fname)
  web.title("AoC-25-06")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/6">Advent of Code 2025 - Day 6: Trash Compactor</a>.</p>]])
end

web.defpal(0, "11c7")
web.defgfx(0, "00410455106610551554155415541004")
web.defgfx(1, "ffffffffffffffffffffffffffffffff")
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

function read(lines)
  local res = {}
  local y = 0
  local w = 1
  local i = 0
  for line in lines do
    web.row(line)
    local x = 0
    for c in line:gmatch(".") do
      if c ~= " " then
        i = i + 1
        res[i] = { c = c, p = vec(x, y), t = nil }
      end
      x = x + 1
    end
    w = math.max(w, x)
    y = y + 1
  end
  return res, vec(w, y)
end

local function move(chars)
  while true do
    local w = 0
    local h = 0
    web.clear()
    local moving = false
    for _, c in ipairs(chars) do
      w = math.max(w, c.p.x)
      h = math.max(h, c.p.y)
      local xs, ys = 0, 0
      if (c.p.x > c.t.x) then
        moving = true
        xs = -1
      elseif (c.p.x < c.t.x) then
        moving = true
        xs = 1
      end
      if (c.p.y > c.t.y) then
        moving = true
        ys = -1
      elseif (c.p.y < c.t.y) then
        moving = true
        ys = 1
      end
      c.p = vec(c.p.x + xs, c.p.y + ys)
      web.string(c.c, 0, c.p.x, c.p.y)
    end
    if not moving then return vec(w, h) end
    web.yield(100)
  end
end

local function solve(lines)
  local chars, size = read(lines)
  local len = math.max(size.x, size.y)
  local scale = 8
  while 8 * scale * len > 600 do
    scale = scale / 2
  end
  web.scale(scale)
  local down = len * 8 - size.y * 8
  for _, c in ipairs(chars) do
    local p = c.p
    c.p = vec(p.x * 8, down + p.y * 8)
    c.t = vec(p.y * 8, len * 8 - p.x * 8)
  end
  web.clear()
  for _, c in ipairs(chars) do
    web.string(c.c, 0, c.p.x, c.p.y)
  end
  web.yield(1000)
  size = move(chars)
  local nums = {}
  for _, c in ipairs(chars) do
    local l = nums[c.p.y] or {}
    l[#l + 1] = c
    nums[c.p.y] = l
  end
  local x = size.x + 8
  local y = -8
  local res, tmp = 0, {}
  while y < size.y + 8 do
    web.gfx(1, 0, x, y)
    y = y + 1
    web.gfx(0, 0, x, y)
    if nums[y] then
      table.sort(nums[y], function(a, b) return a.p.x < b.p.x end)
      local r = {}
      for _, c in ipairs(nums[y]) do
        r[#r + 1] = c.c
      end
      local op, tmpres
      if r[#r]:match("[+*]") then
        local o = r[#r]
        r[#r] = nil
        op = o == "*" and function(a, b) return a * b end or function(a, b) return a + b end
        tmpres = o == "*" and 1 or 0
      end
      local num = table.concat(r, "")
      web.string(num, 0, x + 8, y)
      tmp[#tmp + 1] = tonumber(num)
      if op then
        for _, n in ipairs(tmp) do
          tmpres = op(tmpres, n)
        end
        tmp = {}
        res = res + tmpres
        web.string(tostring(tmpres), 0, size.x * 2 + 24, y)
      end
    end
    web.yield(100)
  end
  web.string(tostring(res), 0, size.x * 2 + 24, y)
  return res
end

local examplestr = [[
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
]]

print(solve(examplestr:gmatch("[^\n]+")))

