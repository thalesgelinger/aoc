local M = {}

local function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function M.lines_from(file)
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

return M
