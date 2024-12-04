require "strings"
local utils = require "utils"

os.execute "clear"

local lines = utils.linesFrom "input/04/input.txt"

local map = {}

for i, line in ipairs(lines) do
    local lm = {}
    for j = 1, #line do
        table.insert(lm, line:sub(j, j))
    end
    table.insert(map, lm)
end


local directions = {
    {
        { 1,  -1 }, --diagnal-right-up
        { -1, 1 },  --diagnal-left-down
    },
    {
        { 1,  1 },  --diagnal-right-down
        { -1, -1 }, --diagnal-left-up
    }
}

local function isValidCoord(x, y)
    if x > #map or x < 1 then
        return false
    end

    if y > #map[x] or y < 1 then
        return false
    end

    return true
end

local result = 0

for l = 1, #map do
    for c = 1, #map[l] do
        local char = map[l][c]

        if char ~= "A" then goto continue end

        local diagCount = 0
        for _, dir in ipairs(directions) do
            local from, to = dir[1], dir[2]
            local fx, fy = l + from[1], c + from[2]
            local tx, ty = l + to[1], c + to[2]

            if not isValidCoord(fy, fx) or not isValidCoord(tx, ty) then
                goto continue
            end

            local charFrom = map[fx][fy]
            local charTo = map[tx][ty]

            local isMAS = charFrom == "S" and charTo == "M" or charFrom == "M" and charTo == "S"
            if isMAS then
                diagCount = diagCount + 1
            end

            ::continue::
        end


        if diagCount == 2 then
            result = result + 1
        end

        ::continue::
    end
end

print(result)
