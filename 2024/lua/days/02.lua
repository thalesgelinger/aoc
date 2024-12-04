require "strings"
local utils = require "utils"

os.execute "clear"

local lines = utils.linesFrom "input/02/input.txt"

local result = 0

--- @param nums number[]
--- @return boolean, [number, number]
local function checkSafe(nums)
    local increasing = (nums[1] - nums[2]) < 0

    local i = 1
    while i < #nums do
        local invalidDir = (nums[i] - nums[i + 1] < 0) ~= increasing
        if invalidDir then
            return false, { i, i + 1 }
        end
        local diff = math.abs(nums[i] - nums[i + 1])
        local invalidDiff = diff < 1 or diff > 3
        if invalidDiff then
            return false, { i, i + 1 }
        end

        i = i + 1
    end
    return true, {}
end

for _, line in ipairs(lines) do
    local nums = line:split(" ")

    local isSafe, errorTuple = checkSafe(nums)

    if isSafe then
        result = result + 1
        goto continue
    end

    local noFirst, lList, rList = {}, {}, {}
    for index, value in ipairs(nums) do
        if index ~= errorTuple[1] then
            table.insert(lList, value)
        end

        if index ~= errorTuple[2] then
            table.insert(rList, value)
        end

        if index ~= 1 then
            table.insert(noFirst, value)
        end
    end


    local isLSafe = checkSafe(lList)
    if isLSafe then
        result = result + 1
        goto continue
    end

    local isRSafe = checkSafe(rList)
    if isLSafe or isRSafe then
        result = result + 1
        goto continue
    end

    local isNoFirstSafe = checkSafe(noFirst)
    if isNoFirstSafe then
        result = result + 1
        goto continue
    end

    ::continue::
end

print(result)
