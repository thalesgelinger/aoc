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
            if i == #producerRaw // 2 + 1 then
                producer.middle = v
            end
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

for _, p in pairs(producers) do
    for k, v in pairs(p) do
        local order = orders[tostring(k)]

        if type(order) ~= "table" then
            goto inner
        end

        for _, o in ipairs(order) do
            if p[o] ~= nil and tonumber(v) > p[o] then
                goto continue
            end
        end

        ::inner::
    end
    result = result + p.middle

    ::continue::
end

print(result)
