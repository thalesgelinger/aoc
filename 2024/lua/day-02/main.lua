require "strings"
local utils = require "utils"

os.execute "clear"

local lines = utils.lines_from "day-02/input.txt"

local result = 0

for _, line in ipairs(lines) do
    local nums = line:split(" ")
    local n = table.remove(nums, 1)
    local shouldIncrease = n - nums[1] < 0

    while (#nums > 0 and (n - nums[1] < 0) == shouldIncrease) do
        local diff = math.abs(n - nums[1])
        if diff < 1 or diff > 3 then break end
        n = table.remove(nums, 1)
    end

    if #nums == 0 then
        result = result + 1
    end
end

print(result)
