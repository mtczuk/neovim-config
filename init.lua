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

vim.keymap.set('n', '<leader>tf', ':Neotree reveal_force_cwd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '\\', ':Neotree toggle<CR>', { noremap = true, silent = true })

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


-- Helper function to get visual selection
local utils = {}
function utils.get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  return table.concat(lines, '\n')
end



local function setup_lsp_keymaps(client, bufnr)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end


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
            setup_lsp_keymaps(client, bufnr)
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
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP servers setup
      local servers = { "pyright", "ts_ls", "rust_analyzer", "eslint" }
      for _, lsp in ipairs(servers) do
        require("lspconfig")[lsp].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            setup_lsp_keymaps(client, bufnr)
          end,
          settings = {
            eslint = {
              eslint = true,
              format = true,
              quiet = false,
              validate = "on",
              filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
            },
          },
        })
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('plugins.telescope').setup()
    end,
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
    config = function()
      require('plugins.neotree').setup()
    end
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


