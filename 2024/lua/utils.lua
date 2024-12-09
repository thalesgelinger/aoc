local M = {}

local function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function M.linesFrom(file)
    print("INPUT: " .. file)
    if not file_exists(file) then
        error("Missing input file to read line")
        return {}
    end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

function M.printHash(t)
    for k, v in ipairs(t) do
        print("K: " .. k, "V: " .. v)
        if type(v) == "table" then
            M.printHash(v)
        end
    end
end

function M.printList(t)
    local str = "["
    for index, value in ipairs(t) do
        str = str .. value
        if index ~= #t then
            str = str .. ","
        end
    end
    str = str .. "]"
    print(str)
end

return M
