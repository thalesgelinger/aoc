local day = arg[1]

if day == nil then
    os.execute "clear"
    error "Please inform a day"
end

require("days." .. day)
