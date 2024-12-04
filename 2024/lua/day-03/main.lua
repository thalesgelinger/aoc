require "strings"
local utils = require "utils"

os.execute "clear"

local lines = utils.linesFrom "day-03/input.txt"

local result = 0


local parser = {
    ch = "",
    line = ""
}

function parser.next()
    parser.ch = parser.line:sub(1, 1)
    parser.line = parser.line:sub(2)
end

function parser.peek()
    return parser.line:sub(1, 1)
end

--- @return number, boolean
function parser.digit()
    if tonumber(parser.peek()) == nil then
        return 0, true
    end

    local digit = ""
    while tonumber(parser.peek()) ~= nil do
        parser.next()
        digit = digit .. parser.ch
    end

    return tonumber(digit), false
end

--- @return string, number|nil, number|nil
function parser.parse()
    parser.next()

    if parser.ch == "m" then
        if parser.line:sub(1, 2) == "ul" then
            parser.next()
            parser.next()

            if parser.peek() == "(" then
                parser.next()
                local n1, err = parser.digit()
                if err then
                    return "", nil, nil
                end

                if parser.peek() == "," then
                    parser.next()
                end

                local n2, err = parser.digit()
                if err then
                    return "", nil, nil
                end

                if parser.peek() == ")" then
                    parser.next()
                    return "MUL", n1, n2
                end
            end
        end
    end

    if parser.ch == "d" then
        if parser.line:sub(1, 4) == "on't" then
            parser.next()
            parser.next()
            parser.next()
            parser.next()

            if parser.line:sub(1, 2) ~= "()" then
                return "INVALID", nil, nil
            end
            return "DONT", nil, nil
        end

        if parser.line:sub(1, 1) == "o" then
            parser.next()
            if parser.line:sub(1, 2) ~= "()" then
                return "INVALID", nil, nil
            end
            return "DO", nil, nil
        end
    end

    return "", nil, nil
end

local should = true
for _, line in ipairs(lines) do
    parser.line = line

    while #parser.line > 0 do
        local fn, v1, v2 = parser.parse()

        if fn == "MUL" and should then
            result = result + v1 * v2
        elseif fn == "DONT" then
            should = false
        elseif fn == "DO" then
            should = true
        end
    end
end

print(result)
