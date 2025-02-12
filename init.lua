-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.mouse = 'a'

vim.opt.clipboard = 'unnamedplus'

-- Basic settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
-- vim.opt.termguicolors = true




vim.keymap.set('n', '<C-j>', '4j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '4k', { noremap = true, silent = true })
-- vim.keymap.set('n', 's', ':HopWord<CR>', { noremap = true, silent = true })

vim.keymap.set('n', 's', function()
  require('hop').hint_char1()
end, { noremap = true, silent = true })


vim.keymap.set('n', '<leader>s', function()
  require('hop').hint_char1()
end, { noremap = true, silent = true })


vim.keymap.set('v', 's', function()
  require('hop').hint_char1()
end, { noremap = true, silent = true })

vim.api.nvim_create_user_command('Reload', function() 
  vim.cmd('source ~/.config/nvim/init.lua')
  print('Neovim config reloaded!')
end, {})



vim.api.nvim_set_keymap( 'n', '<Leader>ds', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap( 'n', '<Leader>dn', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap( 'n', '<Leader>dp', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n','tn', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','tj', ':tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','tk', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','tl', ':tablast<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','th', ':tabfirst<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n','<leader>bc', ':bp|bd #<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>bp', ':bp<CR>', { noremap = true, silent = true })

require("lazy").setup({
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup {
        widget_guides = {
          enabled = true,
        },
        lsp = {
          on_attach = function(client, bufnr)
            require('shared.setup_lsp_keymaps').execute(bufnr)
          end
        }
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = require('plugins.lsp').setup,
  },
  {
    "hrsh7th/nvim-cmp",
    config = require('plugins.nvimcmp').setup
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require('plugins.telescope').setup,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "rust" },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = require('plugins.neotree').setup
  },
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000, 
    config = function()
      vim.cmd.colorscheme('catppuccin')
    end 
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      -- require('vscode').load('dark')
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ts_ls", "rust_analyzer", "eslint" },
        automatic_installation = true,
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({})
    end
  },
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    },
  }
})


