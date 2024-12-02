os.execute "clear"
local aoc = require "aoc"

local lines = aoc.lines_from "input.txt"

local left, right = {}, {}

--- @param str string
--- @return number, number
local function getDigits(str)
    local digits = {}
    for num in string.gmatch(str, "%d+") do
        table.insert(digits, num)
    end
    return digits[1], digits[2]
end

for _, v in ipairs(lines) do
    local ln, rn = getDigits(v)
    table.insert(left, ln)
    table.insert(right, rn)
end

table.sort(left)
table.sort(right)

local result = 0

for k, v in ipairs(left) do
    result = result + math.abs(v - right[k])
end

print(result)
