---@class Runner
local M = {}

--- @param command string
--- @param args string[]?
M.run_command = function(command, args)
    if not args then
        args = {}
    end

    local full_cmd = command .. " " .. table.concat(args, " ")

    local handle = io.popen(full_cmd)

    if not handle then
        return nil
    end

    local content = handle:read("*all")
    handle:close()

    return content
end

return M
