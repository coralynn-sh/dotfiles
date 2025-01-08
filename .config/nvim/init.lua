local config_path = vim.fn.stdpath('config')
vim.cmd("source" .. config_path .. "/qs.vim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
    { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({

                ensure_installed = { "c", "haskell", "markdown"},

                sync_install = false,

                auto_install = true,

                highlight = {
                    enable = true,

                    additional_vim_regex_highlighting = false,
                },})
  end

    },
    { "cappyzawa/trim.nvim", opts = {} },
    { 'numToStr/Comment.nvim', opts = {}, lazy = false},
    { 'Civitasv/cmake-tools.nvim' },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {'tikhomirov/vim-glsl'},
    {'rgroli/other.nvim'},
    {'smithbm2316/centerpad.nvim'},
    {'hiphish/rainbow-delimiters.nvim'},
    {'itchyny/vim-haskell-indent'},
})

require("catppuccin").setup({
    flavor = "mocha",
    transparent_background = true
})

vim.cmd("colorscheme catppuccin")

require('telescope').setup{
    defaults = {
    file_ignore_patterns = {
      "lib"
    }}
}

local telebuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>,', telebuiltin.find_files, {})
vim.keymap.set('n', '<leader> ', telebuiltin.git_files, {})
vim.keymap.set('n', '<leader>/', function()
	telebuiltin.grep_string({ search = vim.fn.input("Grep > ") });
end)

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end)

require('other-nvim').setup({
    mappings = {
        {
            pattern = "(.*).c$",
            target = {
                {
                    target = "%1.h",
                    context = "header",
                },
                {
                    target = "%1.c",
                    context = "code",
                },
                {
                    target = "%1_test.h",
                    context = "test",
                },
            },
            transformer = "ctest",
        },
        {
            pattern = "(.*).h$",
            target = {
                {
                    target = "%1.h",
                    context = "header",
                },
                {
                    target = "%1.c",
                    context = "code",
                },
                {
                    target = "%1_test.h",
                    context = "test",
                },
            },
            transformer = "ctest",
        },
    },
    transformers = {
        ctest = function (inputString)
            return string.gsub(inputString, "_test", "")
        end
    },
})

local rainbow_delimiters = require 'rainbow-delimiters'

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.purs"},
    command = "set filetype=haskell",
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.h"},
    command = "set filetype=c",
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.gdshaderinc"},
    command = "set filetype=gdshader",
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.py"},
    command = "set tabstop=4 softtabstop=4 shiftwidth=4",
})

vim.api.nvim_create_autocmd({"BufLeave", "BufWinLeave"}, {
    pattern = {"*.py"},
    command = "set tabstop=2 softtabstop=2 shiftwidth=2",
})

vim.keymap.set('n', '<leader>oh', '<cmd>:Other header<CR>')
vim.keymap.set('n', '<leader>ot', '<cmd>:Other test<CR>')
vim.keymap.set('n', '<leader>oc', '<cmd>:Other code<CR>')

vim.keymap.set('n', '<leader>bc', '<cmd>:Centerpad<CR>')

vim.cmd("source" .. config_path .. "/snippets.vim")
