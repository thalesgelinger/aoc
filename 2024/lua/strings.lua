function string:split(delimiter)
    if delimiter == "" or delimiter == nil then
        error("Delimiter cannot be empty or nil")
    end

    local result = {}
    for part in string.gmatch(self, "([^" .. delimiter .. "]+)") do
        table.insert(result, part)
    end
    return result
end
