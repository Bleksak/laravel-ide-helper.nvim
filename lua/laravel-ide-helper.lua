-- main module file
local models = require("laravel-ide-helper.models")

---@class Config
---@field save_before_write boolean writes to disk before generating model data (prevents desync between buffer/disk)
---@field format_after_gen boolean formats the buffer after generating model data
local config = {
    save_before_write = true,
    format_after_gen = true,
    models_args = {},
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
    if M.config.save_before_write then
        vim.cmd("w")
    end
    vim.schedule(function()
        if models.generate_models(file) then
            vim.cmd("e")
        end
    end)
    vim.schedule(function()
        if M.config.format_after_gen then
            vim.lsp.buf.format()
        end
    end)
end

return M
