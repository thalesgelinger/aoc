require "strings"
local utils = require "utils"

os.execute "clear"

local lines = utils.linesFrom "input/06/input.txt"

local OBSTRUCTION = "#"
local MARK = "X"
local guard_dir = {
    up = "^",
    left = "<",
    right = ">",
    down = "v"
}

local dirs = {
    { 0,  -1 }, -- up
    { 1,  0 },  -- right
    { 0,  1 },  -- down
    { -1, 0 },  -- left
}

local map = {}
for i, line in ipairs(lines) do
    local m_line = {}
    for j = 1, #line do
        local char = line:sub(j, j)
        table.insert(m_line, char)
    end
    table.insert(map, m_line)
end


local function findStartPos()
    for i, _ in ipairs(map) do
        for j, char in ipairs(map[i]) do
            if char == guard_dir.up then
                return i, j
            end
        end
    end
    return -1, -1
end


local x, y = findStartPos()


local dir = map[x][y]

Moves = {
    [guard_dir.up] = function(cx, cy)
        local nx, ny = cx - 1, cy
        local peekUp = map[nx][ny]
        if peekUp == OBSTRUCTION then
            return Moves[guard_dir.right](cx, cy)
        end
        map[cx][cy] = MARK
        map[nx][ny] = guard_dir.up
        return nx, ny
    end,
    [guard_dir.right] = function(cx, cy)
        local nx, ny = cx, cy + 1
        local peekUp = map[nx][ny]
        if peekUp == OBSTRUCTION then
            return Moves[guard_dir.down](cx, cy)
        end
        map[cx][cy] = MARK
        map[nx][ny] = guard_dir.right
        return nx, ny
    end,
    [guard_dir.down] = function(cx, cy)
        local nx, ny = cx + 1, cy
        local peekUp = map[nx][ny]
        if peekUp == OBSTRUCTION then
            return Moves[guard_dir.left](cx, cy)
        end
        map[cx][cy] = MARK
        map[nx][ny] = guard_dir.down
        return nx, ny
    end,
    [guard_dir.left] = function(cx, cy)
        local nx, ny = cx, cy - 1
        local peekUp = map[nx][ny]
        if peekUp == OBSTRUCTION then
            return Moves[guard_dir.up](cx, cy)
        end
        map[cx][cy] = MARK
        map[nx][ny] = guard_dir.left
        return nx, ny
    end,
}

while x > 0 and y > 0 do
    if x + 1 > #map or x - 1 < 1 or y + 1 > #map[1] or y - 1 < 1 then break end
    x, y = Moves[dir](x, y)
    -- print("Line: ", x, "Column: ", y)
    dir = map[x][y]
end

local pos_count = 0

for i, v in ipairs(map) do
    local str = ""
    for _, c in ipairs(v) do
        if c == MARK then
            pos_count = pos_count + 1
        end
        str = str .. c
    end
    -- print(str)
end


pos_count = pos_count + 1

print(pos_count)
