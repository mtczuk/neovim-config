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

require("general").setup()

require("lazy").setup({
	require("plugins.flutter"),
	require("plugins.lsp"),
	require("plugins.nvimcmp"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.lualine"),
	require("plugins.neotree"),
	require("plugins.mason"),
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
	require("plugins.git"),
	require("plugins.dap"),
	require("plugins.colors"),
	require("plugins.autopairs"),
	require("plugins.tailwind"),
})

vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
