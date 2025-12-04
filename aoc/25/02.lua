local fname
if not web then
  local f
  f = function() return f end
  web = setmetatable({}, { __index = f })
  fname = arg and arg[1]
else
  fname = "input"
  web.file(fname)
  web.title("AoC-25-01")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/2">Advent of Code 2025 - Day 2: Gift Shop</a>.</p>]])
end

local f <close> = fname and io.open(fname)

web.defpal(0, "11c5")
web.defgfx(0, "00410455106610551554155415541004")

local function solve(str)
  local res1, res2 = 0, 0
  local function invalid(s, repeats)
    local r = s:sub(1, #s // repeats):rep(repeats)
    local x, y1, y2 = 8, 8, 16
    web.clear()
    web.string(res1, 0, 8, 24)
    web.string(res2, 0, 8, 32)
    for i = 1, math.max(#s, #r) do
      local a, b = s:sub(i, i), r:sub(i, i)
      local pal = a == b and 0 or 1
      web.string(a, pal, x, y1)
      web.string(b, pal, x, y2)
      x = x + 8
    end
    web.gfx(0, 0, x, y1)
    web.gfx(0, 0, x, y2)
    web.yield(0)
    return s == r
  end

  local function invalid2(s)
    for r = 2, #s do
      if invalid(s, r) then return true end
    end
    return false
  end

  for a, b in str:gmatch("(%d+)-(%d+)") do
    a, b = tonumber(a), tonumber(b)
    for n = a, b do
      local s = tostring(n)
      local r1 = invalid(s, 2)
      if r1 then
        web.gfx(0, 0, 0, 24)
        res1 = res1 + n
        web.yield(200)
      end
      local r2 = invalid2(s)
      if invalid2(s) then
        web.gfx(0, 0, 0, 32)
        res2 = res2 + n
        web.yield(200)
      end
    end
  end
  web.clear()
  web.gfx(0, 0, 0, 24)
  web.gfx(0, 0, 0, 32)
  web.string(res1, 0, 8, 24)
  web.string(res2, 0, 8, 32)
  return res1, res2
end

local examplestr = [[
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124
]]

print("with example:")
print(solve(examplestr))
if f then
  print("\nwith file input:")
  print(solve(f:read("*all")))
end

