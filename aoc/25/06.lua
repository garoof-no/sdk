local fname
local selfy
if not web then
  selfy = function() return selfy end
  web = setmetatable({}, { __index = selfy })
  fname = arg and arg[1]
else
  fname = "input"
  web.file(fname)
  web.title("AoC-25-06")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/6">Advent of Code 2025 - Day 6: Trash Compactor</a>.</p>]])
end

local f <close> = fname and io.open(fname)

local function solve(lines)
  local res1, res2 = 0, 0
  local lists1, lists2 = {}, {}
  for line in lines do
    local i = 0
    for d in line:gmatch("%d+") do
      i = i + 1
      local l = lists1[i] or {}
      l[#l + 1] = tonumber(d)
      lists1[i] = l
    end
    if i > 0 then
      local j = 0
      for c in line:gmatch(".") do
        j = j + 1
        if c:match("%d") then
          local l = lists2[j] or {}
          l[#l + 1] = c
          lists2[j] = l
        end
      end
    else
      local j = 0
      for c in line:gmatch(".") do
        j = j + 1
        if c:match("[*+]") then
          i = i + 1
          local op = c == "*" and function(a, b) return a * b end or function(a, b) return a + b end
          local id = c == "*" and 1 or 0
          local r1, r2 = id, id
          for _, n in ipairs(lists1[i]) do
            r1 = op(r1, n)
          end
          res1 = res1 + r1
          local k = j
          while lists2[k] do
            local n = tonumber(table.concat(lists2[k]))
            r2 = op(r2, n)
            k = k + 1
          end
          res2 = res2 + r2
        end
      end
    end
  end
  return res1, res2
end

local examplestr = [[
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
]]

print("with example:")
print(solve(examplestr:gmatch("[^\n]+")))

if f then
  print("\nwith file input:")
  print(solve(f:lines()))
end

if not selfy then
  web.scale(8)
  web.defpal(0, "3395")
  web.defgfx(0, "00410455106610551554155415541004")
  local x, y = 64, 64
  local xs, ys = 1, 1
  while true do
    if xs == 1 and x + 8 >= 100 then xs = -1
    elseif xs == -1 and x < 0 then xs = 1
    end
    if ys == 1 and y + 8 >= 75 then ys = -1
    elseif ys == -1 and y <= 0 then ys = 1
    end
    x = x + xs
    y = y + ys
    web.clear()
    web.gfx(0, 0, x, y)
    web.yield(50)
  end
end

