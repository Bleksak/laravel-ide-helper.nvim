---@class Helpers
local M = {}

local runner = require("laravel-ide-helper.runner")

M.root = function()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
end

M.file_to_model_string = function(file)
    return vim.fn.fnamemodify(file, ":t:r")
end

M.model_data = function(model)
    local content = runner.run_command("php", {
        "artisan",
        "model:show",
        "--json",
        model,
    })

    if content == nil then
        return nil
    end

    local status, json = pcall(vim.json.decode, content)

    if not status then
        return nil
    end

    return json
end

--- @param model_data table
M.model_fqn = function(model_data)
    return model_data.class
end

return M
