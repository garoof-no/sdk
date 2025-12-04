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

web.defpal(0, "70c5")
web.defpal(1, "78c5")
web.defgfx(0, "05401450501450145014145005400000")
web.defgfx(1, "01400540154001400140014015540000")
web.defgfx(2, "05501414001401500500141415540000")
web.defgfx(3, "15540014005001500014141405500000")
web.defgfx(4, "01500550145050505554005001540000")
web.defgfx(5, "15541400140015500014141415500000")
web.defgfx(6, "05501400500055505014501415500000")
web.defgfx(7, "55545014005001400500050005000000")
web.defgfx(8, "15505014501415505014501415500000")
web.defgfx(9, "15505014501415540014005015400000")
web.defgfx(10, "00410455106610551554155415541004")
web.defpal(2, "11c5")

local function drawnum(n, x, y)
  for c in tostring(n):gmatch(".") do
    web.gfx(c, 0, x, y)
    x = x + 8
  end
end

local function solve(str)
  web.clear()
  local res1, res2 = 0, 0
  local function invalid(s, repeats)
    local r = s:sub(1, #s // repeats):rep(repeats)
    local x, y1, y2 = 8, 8, 16
    for i = 1, math.max(#s, #r) do
      local a, b = s:sub(i, i), r:sub(i, i)
      local pal = a == b and 0 or 1
      web.gfx(a, pal, x, y1)
      web.gfx(b == "" and 10 or b, pal, x, y2)
      x = x + 8
    end
    web.gfx(10, 2, x, y1)
    web.gfx(10, 2, x, y2)
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
      web.gfx(10, r1 and 0 or 1, 0, 24)
      if r1 then
        res1 = res1 + n
        drawnum(res1, 8, 24)
        web.yield(200)
      end
      local r2 = invalid2(s)
      web.gfx(10, r2 and 0 or 1, 0, 32)
      if invalid2(s) then
        res2 = res2 + n
        drawnum(res2, 8, 32)
        web.yield(200)
      end
    end
  end
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

