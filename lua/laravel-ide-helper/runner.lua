---@class Runner
local M = {}

--- @param command string
--- @param args string[]?
M.run_command = function(command, args)
    if not args then
        args = {}
    end

    local full_cmd = command .. " " .. table.concat(args, " ")
    print(full_cmd)

    local handle = io.popen(full_cmd)

    if not handle then
        return nil
    end

    local result = handle:read("a")
    handle:close()

    return result
end

return M
