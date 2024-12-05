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
    { 'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = { 'nvim-lua/plenary.nvim' } },
    { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({

                ensure_installed = { "c", "lua", "rust", "go", "javascript", "markdown"},

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,


                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

                highlight = {
                    enable = true,

                    additional_vim_regex_highlighting = false,
                },})
  end

    },
    { "cappyzawa/trim.nvim", opts = {} },
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    { 'numToStr/Comment.nvim', opts = {}, lazy = false},
    { 'Civitasv/cmake-tools.nvim' },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {'tikhomirov/vim-glsl'},
    {'rgroli/other.nvim'},
    {'vim-crystal/vim-crystal'},
    {'smithbm2316/centerpad.nvim'},
    {'hiphish/rainbow-delimiters.nvim'},
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

vim.keymap.set("n", "<leader>e", '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<leader>bf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
  require('lspconfig')[server].setup({
    capabilities = lsp_capabilities,
  })
end

-- require'lspconfig'.clangd.setup{}

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    default_setup,
  },
})

-- local cmp = require('cmp')
--
-- cmp.setup({
--   sources = {
--     {name = 'nvim_lsp'},
--   },
--   mapping = cmp.mapping.preset.insert({
--     -- Enter key confirms completion item
--     ['<CR>'] = cmp.mapping.confirm({select = false}),
--     -- Ctrl + space triggers completion menu
--     ['<C-Space>'] = cmp.mapping.complete(),
--   }),
--   snippet = {
--     expand = function(args)
--       local ls = require('luasnip')
--       ls.lsp_expand(args.body)
--       vim.keymap.set({"i", "s"}, "<C-l>", function() ls.jump( 1) end, {silent = true})
--       vim.keymap.set({"i", "s"}, "<C-h>", function() ls.jump(-1) end, {silent = true})
--     end,
--   },
-- })

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


vim.keymap.set('n', '<leader>oh', '<cmd>:Other header<CR>')
vim.keymap.set('n', '<leader>ot', '<cmd>:Other test<CR>')
vim.keymap.set('n', '<leader>oc', '<cmd>:Other code<CR>')

vim.keymap.set('n', '<leader>bc', '<cmd>:Centerpad<CR>')

vim.cmd("source" .. config_path .. "/snippets.vim")
