---@class Models
local M = {}

local helpers = require("laravel-ide-helper.helpers")
local runner = require("laravel-ide-helper.runner")

---@param write_to_models boolean
---@param file string?
M.generate_models = function(write_to_models, file)
    print(file)
    local command = "php"

    local args = {
        "artisan",
        "ide-helper:models",
        "-n",
    }

    if write_to_models then
        table.insert(args, "-W")
    end

    if file then
        local current_model = helpers.file_to_model_string(file)
        local model_data = helpers.model_data(current_model)

        if model_data == nil then
            print("Error: couldn't find model" .. current_model)
            return
        end

        local fqn = helpers.model_fqn(model_data)
        table.insert(args, '"' .. fqn .. '"')
    end

    local result = runner.run_command(command, args)
    if not result then
        print("Error: couldn't generate models")
    end

    print("OK: Model info generated")
end

return M
