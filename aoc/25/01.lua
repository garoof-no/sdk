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
end

local f <close> = fname and io.open(fname)

web.defpal(0, "00c5")
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
web.defpal(1, "11c5")

local function num(n, x, y)
  for d in tostring(n):reverse():gmatch(".") do
    web.send("gfx", tonumber(d) .. " 0 " .. x .. " " .. y)
    x = x - 8
  end
end

local function dial()
  local current, stops, passes = 50, 0, 0
  local function step(n)
    current = (current + n) % 100
    if current == 0 then passes = passes + 1 end
    local r = ((current - 25) / 50) * math.pi
    local y = 40 + (32 * math.sin(r))
    local x = 40 + (32 * math.cos(r))
    web.send("clear", "7")
    web.send("gfx", "10 1 " .. x .. " " .. y)
    num(stops, 56, 88)
    num(passes, 56, 96)
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

