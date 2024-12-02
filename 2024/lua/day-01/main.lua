os.execute "clear"
require "strings"

local utils = require "utils"
local lines = utils.lines_from "day-01/example.txt"

local left, right = {}, {}

for _, v in ipairs(lines) do
    local s = v:split(" ")
    table.insert(left, s[1])
    table.insert(right, s[2])
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
