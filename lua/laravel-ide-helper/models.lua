---@class Models
local M = {}

local helpers = require("laravel-ide-helper.helpers")
local runner = require("laravel-ide-helper.runner")

---@param file string?
M.generate_models = function(file)
    local command = "php"

    local args = {
        "artisan",
        "ide-helper:models",
        "-n",
    }

    local models_args = require("laravel-ide-helper").config.models_args

    for _, arg in ipairs(models_args) do
        table.insert(args, arg)
    end

    if file then
        local current_model = helpers.file_to_model_string(file)
        local model_data = helpers.model_data(current_model)

        if model_data == nil then
            print("Error: couldn't find model" .. current_model)
            return false
        end

        local fqn = helpers.model_fqn(model_data)
        table.insert(args, '"' .. fqn .. '"')
    end

    local result = runner.run_command(command, args)
    if not result then
        print("Error: couldn't generate models")
        return false
    end

    print("OK: Model info generated")
    return true
end

return M
