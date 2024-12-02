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


local appears = {}

for _, v in ipairs(right) do
    if appears[v] then
        appears[v] = appears[v] + 1
    else
        appears[v] = 1
    end
end

local result = 0

for _, v in ipairs(left) do
    if appears[v] then
        result = result + v * appears[v]
    end
end

print(result)
