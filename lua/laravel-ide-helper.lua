-- main module file
local models = require("laravel-ide-helper.models")

---@class Config
---@field write_to_models boolean Your config option
local config = {
    write_to_models = true,
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param opts Config?
M.setup = function(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

---@param file string?
M.generate_models = function(file)
    models.generate_models(M.config.write_to_models, file)
    vim.cmd("e")
end

return M
