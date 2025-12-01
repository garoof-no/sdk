local fname
if web then
  web.title("AoC25,1")
  fname = "input"
  web.file(fname)
else
  fname = arg and arg[1]
end

local f <close> = fname and io.open(fname)

web.defgfx(0, "00410455106610551554155415541004")
web.defpal(0, "11c5")

local function dial()
  local current, stops, passes = 50, 0, 0
  local function step(n)
    current = (current + n) % 100
    if current == 0 then passes = passes + 1 end
    local r = (current / 50) * math.pi
    local x = 50 + (25 * math.sin(r))
    local y = 50 + (25 * math.cos(r))
    web.send("clear")
    web.send("gfx", "0 0 " .. x .. " " .. y)
    web.yield()
  end
  local function steps(n, c)
    for _ = 1, c do step(n) end
    if current == 0 then stops = stops + 1 end
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

