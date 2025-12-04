local fname
if not web then
  local f
  f = function() return f end
  web = setmetatable({}, { __index = f })
  fname = arg and arg[1]
else
  fname = "input"
  web.file(fname)
  web.title("AoC-25-03")
  web.html([[<p>See <a href="https://adventofcode.com/2025/day/3">Advent of Code 2025 - Day 3: Lobby</a>.</p>]])
end

local f <close> = fname and io.open(fname)

local memory = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }

local function largest(line, n)
  if n == 0 then return ""
  elseif n > #line then return nil
  elseif n == #line then return line
  end
  if memory[n][line] then return memory[n][line] end
  local a = line:sub(1, 1) .. largest(line:sub(2), n - 1)
  local b = largest(line:sub(2), n)
  local res = b and tostring(math.max(tonumber(a), tonumber(b))) or a
  memory[n][line] = res
  return res
end

local function solve(lines)
  local res1, res2 = 0, 0
  for line in lines do
    local r1 = tonumber(largest(line, 2))
    local r2 = tonumber(largest(line, 12))
    res1 = res1 + r1
    res2 = res2 + r2
  end
  return res1, res2
end

local examplestr = [[
987654321111111
811111111111119
234234234234278
818181911112111
]]

print("with example:")
  print(solve(examplestr:gmatch("[^\n]+")))

if f then
  print("\nwith file input:")
  print(solve(f:lines()))
end

