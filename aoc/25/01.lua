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
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/1">Advent of Code 2025 - Day 1: Secret Entrance</a>.</p>]])
end

local f <close> = fname and io.open(fname)

web.defpal(0, "11c5")
web.defgfx(0, "00410455106610551554155415541004")

local function dial()
  local current, stops, passes = 50, 0, 0
  local function step(n)
    current = (current + n) % 100
    if current == 0 then passes = passes + 1 end
    local r = ((current - 25) / 50) * math.pi
    local y = 40 + (32 * math.sin(r))
    local x = 40 + (32 * math.cos(r))
    web.clear(7)
    web.gfx(0, 0, x, y)
    web.string(stops, 0, 56, 88, true)
    web.string(passes, 0, 56, 96, true)
    web.yield(10)
  end
  local function steps(n, c)
    for _ = 1, c do step(n) end
    if current == 0 then stops = stops + 1 end
    web.yield(100)
  end
  return {
    L = function(n) steps(-1, n) end,
    R = function(n) steps(1, n) end,
    res = function() return stops, passes end
  }
end

local function solve(lines)
  local d = dial()
  for line in lines do
    local c, n = line:match("([RL])(%d+)")
    if c then d[c](tonumber(n)) end
  end
  return d.res()
end

local examplestr = [[
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
]]

if f then
  print("\nwith file input:")
  print(solve(f:lines()))
else
  print("with example:")
  print(solve(examplestr:gmatch("[^\n]+")))
end

