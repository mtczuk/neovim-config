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

require('general').setup()

require("lazy").setup({
	require("plugins.flutter"),
	require("plugins.lsp"),
	{
		"hrsh7th/nvim-cmp",
		config = require("plugins.nvimcmp").setup,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-live-grep-args.nvim" },
		config = require("plugins.telescope").setup,
	},
	require('plugins.treesitter'),
	require('plugins.lualine'),
	require("plugins.neotree"),
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		config = function()
			require("vscode").load("dark")
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "ts_ls", "rust_analyzer", "eslint" },
				automatic_installation = true,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
	},
	require("plugins.conform"),
	require("plugins.neogit"),
	require("plugins.dap"),
	{
		"bluz71/vim-moonfly-colors",
		config = function()
			-- vim.cmd.colorscheme("moonfly")
		end,
	},
})
