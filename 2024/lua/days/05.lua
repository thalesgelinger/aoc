require "strings"
local utils = require "utils"

os.execute "clear"

local lines = utils.linesFrom "input/05/input.txt"

local orders = {}
local producers = {}

local eol = false

for index, value in ipairs(lines) do
    if value == "" then
        eol = true
        goto continue
    end

    if eol then
        local producerRaw = value:split(",")
        local producer = {}
        for i, v in ipairs(producerRaw) do
            producer[v] = i
        end
        table.insert(producers, producer)
    else
        local order = value:split("|")
        local k, v = order[1], order[2]
        if type(orders[k]) ~= "table" then
            orders[k] = { v }
        else
            table.insert(orders[k], v)
        end
    end

    ::continue::
end


local result = 0

local function checkAndOrder(p)
    local middle = 0
    for k, v in pairs(p) do
        local order = orders[tostring(k)]

        if type(order) ~= "table" then
            goto inner
        end

        for _, o in ipairs(order) do
            if p[o] ~= nil and tonumber(v) > p[o] then
                p[k], p[o] = p[o], p[k]
                checkAndOrder(p)
                return false
            end
        end

        ::inner::
    end
    return true
end

local function count_keys(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

for _, p in pairs(producers) do
    if not checkAndOrder(p) then
        for k, v in pairs(p) do
            if v == count_keys(p) // 2 + 1 then
                result = result + k
            end
        end
    end
end

print(result)
