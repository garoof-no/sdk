local fname
if not web then
  local f
  f = function() return f end
  web = setmetatable({}, { __index = f })
  fname = arg and arg[1]
else
  fname = "input"
  web.file(fname)
  web.title("AoC-25-05")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/5">Advent of Code 2025 - Day 5: Cafeteria</a>.</p>]])
end

local f <close> = fname and io.open(fname)

web.defpal(0, "22e5")
web.defgfx(0, "00410455106610551554155415541004")
web.clear()
web.string("an cat:", 0, 8, 8)
web.gfx(0, 0, 64, 8)

local function check(n, rs)
  for _, r in ipairs(rs) do
    if n >= r.low and n <= r.high then return true end
  end
  return false
end

local function solve(lines)
  local res1, res2 = 0, 0
  local ranges = {}
  for line in lines do
    local a, b = line:match("(%d+)-(%d+)")
    if a then
      ranges[#ranges + 1] = { low = tonumber(a), high = tonumber(b) }
    else
      local n = line:match("(%d+)")
      if n then
        if check(tonumber(n), ranges) then res1 = res1 + 1 end
      end
    end
  end
  table.sort(ranges, function(a, b) return a.low < b.low end)
  local prev = 0
  for _, r in ipairs(ranges) do
    prev = math.max(prev, r.low)
    if prev <= r.high then
      res2 = res2 + 1 + r.high - prev
      prev = r.high + 1
    end
  end
  return res1, res2
end

local examplestr = [[
3-5
10-14
16-20
12-18

1
5
8
11
17
32
]]

print("with example:")
  print(solve(examplestr:gmatch("[^\n]+")))

if f then
  print("\nwith file input:")
  print(solve(f:lines()))
end

