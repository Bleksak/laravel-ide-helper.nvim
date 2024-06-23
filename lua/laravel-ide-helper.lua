-- main module file
local models = require("laravel-ide-helper.models")

---@class Config
---@field write_to_models boolean adds -W ide-helper:models command
---@field save_before_write boolean writes to disk before generating model data (prevents desync between buffer/disk)
local config = {
    write_to_models = true,
    save_before_write = true,
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
        if models.generate_models(M.config.write_to_models, file) then
            vim.cmd("e")
        end
    end)
end

return M
