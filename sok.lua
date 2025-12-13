web.title("An sokoban")

local level = [[

    #####
    #   #
    #$  #
  ###  $##
  #  $ $ #
### # ## #   ######
#   # ## #####  ..#
# $  $          ..#
##### ### #@##  ..#
    #     #########
    #######

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
function Vec.__sub(a, b) return Vec(a.x - b.x, a.y - b.y) end
function Vec.__unm(v) return Vec(-v.x, -v.y) end
function Vec.__tostring(a) return a.x .. "," .. a.y end
local N, E, S, W = Vec(0, -1), Vec(1, 0), Vec(0, 1), Vec(-1, 0)

local function read(lines)
  local goals = {}
  local stuff = {}
  local cat
  local y = 0
  local w = 0
  for line in lines do
    y = y + 1
    local x = 0
    for c in line:gmatch(".") do
      x = x + 1
      local p = Vec(x, y)
      if c == "." or c == "*" or c == "+" then goals[p] = "." end
      if c == "@" or c == "+" then cat = p end
      if c == "$" or c == "*" then stuff[p] = "$" end
      if c == "#" then stuff[p] = "#" end
    end
    w = math.max(x, w)
  end
  return {
    size = Vec(w, y),
    goals = goals,
    stuff = stuff,
    undo = {},
    redo = {},
    cat = { p = cat, f = "" }
  }
end

local function terraingfx(game, p)
  if game.stuff[p] == "#" then return wall, wallp end
  if game.goals[p] then return goal, floorp end
  return floor, floorp
end

local function drawterrain(game)
  for y = 1, game.size.y do
    for x = 1, game.size.x do
      local gfx, pal = terraingfx(game, Vec(x, y))
      web.gfx(gfx, pal, x * 8, y * 8)
    end
  end
end

local function drawyarn(game)
  local pal = wallp
  for p, v in pairs(game.stuff) do
    if v == "$" then
      local gfx = game.goals[p] and yarng or yarn
      web.gfx(gfx, pal, p.x * 8, p.y * 8)
    end
  end
end

local function drawcat(game)
  local p = game.cat.p
  local gfx = game.goals[p] and catg or cat
  web.gfx(gfx, catp, p.x * 8, p.y * 8)
end

local function drawmoves(game)
  local l = game.undo
  local start
  local x, y = 8, (game.size.y * 8) + 8
  if #l > game.size.x then
    start = #l + 2 - game.size.x
    web.string("~", 0, x, y)
    x = x + 8
  else start = 1
  end
  for i = start, #l do
    web.string(l[i], 0, x, y)
    x = x + 8
  end
end

local moves = {
  u = N, d = S, l = W, r = E,
  [N] = "u", [S] = "d", [W] = "l", [E] = "r"
}

local function won(game)
  for p, _ in pairs(game.goals) do
    if not game.stuff[p] then return false end
  end
  return true
end

local function move(game, dir, redo)
  return function()
    if won(game) then return end
    local p = game.cat.p + dir
    local stuff = game.stuff[p]
    if stuff == "#" then return end
    local np = p + dir
    if stuff and game.stuff[np] then return end
    local letter = moves[dir]
    if stuff then
      game.stuff[p] = nil
      game.stuff[np] = stuff
      letter = letter:upper()
    end
    game.cat.p = game.cat.p + dir
    game.undo[#game.undo + 1] = letter
    if not redo then game.redo = {} end
  end
end

local function undo(game)
  local l = game.undo
  if #l == 0 then return end
  local letter = l[#l]
  l[#l] = nil
  game.redo[#game.redo + 1] = letter
  local dir = moves[letter:lower()]
  local cp = game.cat.p
  game.cat.p = cp - dir
  if letter:upper() == letter then
    game.stuff[cp] = game.stuff[cp + dir]
    game.stuff[cp + dir] = nil
  end
end

local function redo(game)
  local l = game.redo
  if #l == 0 then return end
  local letter = l[#l]
  l[#l] = nil
  move(game, moves[letter:lower()], true)()
end

web.buttons(" W R Y")
web.buttons("ASD")
web.buttons("Z  ")

local game = read(level:gmatch("[^\n]*"))

local commands = {
  W = move(game, N),
  A = move(game, W),
  S = move(game, S),
  D = move(game, E),
  Z = function() undo(game) end,
  R = function() while #game.undo > 0 do undo(game) end end,
  Y = function() redo(game) end
}

while true do
  web.clear()
  drawterrain(game)
  drawyarn(game)
  drawcat(game)
  drawmoves(game)
  if won(game) then web.string("flinke pusen :)", 0, 8, (game.size.y * 8) + 16) end
  commands[web.button()]()
end


