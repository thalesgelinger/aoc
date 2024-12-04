require "strings"
local utils = require "utils"

os.execute "clear"

local lines = utils.linesFrom "day-04/input.txt"

local map = {}

for i, line in ipairs(lines) do
    local lm = {}
    for j = 1, #line do
        table.insert(lm, line:sub(j, j))
    end
    table.insert(map, lm)
end


--- @type table<[number,number]>
local directions = {
    { 1,  0 },  --horizontal-right
    { -1, 0 },  --horizontal-left
    { 0,  1 },  --vertical-down
    { 0,  -1 }, --vertical-up
    { 1,  -1 }, --diagnal-right-up
    { 1,  1 },  --diagnal-right-down
    { -1, 1 },  --diagnal-left-down
    { -1, -1 }, --diagnal-left-up
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

        if char == "X" then
            map[l][c] = "-"

            for _, dir in ipairs(directions) do
                local x, y = dir[1], dir[2]

                local mx, my = l + x, c + y

                if not isValidCoord(mx, my) or map[mx][my] ~= "M" then
                    goto continue
                end

                local ax, ay = mx + x, my + y
                if not isValidCoord(ax, ay) or map[ax][ay] ~= "A" then
                    goto continue
                end

                local sx, sy = ax + x, ay + y
                if not isValidCoord(sx, sy) or map[sx][sy] ~= "S" then
                    goto continue
                end

                result = result + 1

                ::continue::
            end
        end
    end
end

print(result)
