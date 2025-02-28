# Laravel IDE Helper for neovim

## Requirements

- neovim
- laravel-ide-helper installed

## Installation (lazy.nvim)

```lua
{
    "Bleksak/laravel-ide-helper.nvim",
    opts = {
        save_before_write = true,
        format_after_gen = true,
        models_args = {},
    },
    enabled = function()
        return vim.fn.filereadable("artisan") ~= 0
    end,
    keys = {
        { "<leader>lgm", function() require("laravel-ide-helper").generate_models(vim.fn.expand("%")) end, desc = "Generate Model Info for current model" },
        { "<leader>lgM", function() require("laravel-ide-helper").generate_models() end, desc = "Generate Model Info for all models" },
    }
}
```

## Features

- Generate Model Info

### Contributing

Feel free to open a pull request if you find any issues or want to improve this plugin in any way.
