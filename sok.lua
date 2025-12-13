web.title("An sokoban")

local level = [[
             
   #####     
   #   ##### 
 ###    $ .# 
 #    @  *.# 
 #####  $### 
     #   #   
     #####   
             
]]

local cat = web.defgfx(0, "00410455106610551554155415541004")
local catg = web.defgfx("00000441105510661555000000000000")
local floor = web.defgfx("10004010400400040000004001000100")
local goal = web.defgfx("100040104104040400002aa800000100")
local wall = web.defgfx("65556555aaaa556555655565aaaa6555")
local yarn = web.defgfx("000005501fd435741f5c15d405700000")
local yarng = web.defgfx("00000000000005501fd4000000000000")
local catp = web.defpal(0, "11c5")
local floorp = web.defpal("3b14")
local wallp = web.defpal("224e")
web.legend(" ", floor, floorp)
web.legend("*", goal, floorp)
web.legend("+", goal, floorp)
web.legend("#", wall, wallp)

local vecs = setmetatable({}, { __mode = "v" })
local Vec = setmetatable(
  {},
  {
    __call = function(V, x, y)
      local key = x .. "," .. y
      local found = vecs[key]
      if found then return found end
      local v = setmetatable({ x = x, y = y}, V)
      vecs[key] = v
      return v
    end
  }
)
function Vec.__add(a, b) return Vec(a.x + b.x, a.y + b.y) end
function Vec.__tostring(a) return a.x .. "," .. a.y end
local N, E, S, W = Vec(0, -1), Vec(1, 0), Vec(0, 1), Vec(-1, 0)

local function read(lines)
  local terrain = {}
  local yarn = {}
  local cat
  local y = 0
  local w = 0
  for line in lines do
    y = y + 1
    local x = 0
    for c in line:gmatch(".") do
      x = x + 1
      local p = vec(x, y)
      if c == "." or c == "*" or c == "+" then terrain[p] = "." end
      if c == "@" or c == "+" then cat = p end
      if c == "$" or c == "*" then yarn[p] = "$" end
      if c == "#" then terrain[p] = "#" end
    end
    w = math.max(x, w)
  end
  return { size = vec(w, y), terrain = terrain, yarn = yarn, cat = cat }
end

local function terraingfx(map, p)
  local x = map.terrain[p]
  if x == "#" then return wall, wallp
  elseif x == "." then return goal, floorp
  else return floor, floorp
  end
end

local map = read(level:gmatch("[^\n]*"))

local function drawterrain(map)
  for y = 1, map.size.y do
    for x = 1, map.size.x do
      local gfx, pal = terraingfx(map, vec(x, y))
      web.gfx(gfx, pal, x * 8, y * 8)
    end
  end
end

local function drawyarn(map)
  local pal = wallp
  for p, _ in pairs(map.yarn) do
    local gfx = map.terrain[p] == "." and yarng or yarn
    web.gfx(gfx, pal, p.x * 8, p.y * 8)
  end
end

local function drawcat(map)
  local p = map.cat
  local pal = catp
  local gfx = map.terrain[p] and catg or cat
  web.gfx(gfx, pal, p.x * 8, p.y * 8)
end

web.buttons(" W ")
web.buttons("ASD")

local function move(map, dir)
  return function()
    map.cat = map.cat + dir
  end
end

local commands = {
  W = move(map, N),
  A = move(map, W),
  S = move(map, S),
  D = move(map, E)
}

while true do
  web.clear()
  drawterrain(map)
  drawyarn(map)
  drawcat(map)
  commands[web.button()]()
end


