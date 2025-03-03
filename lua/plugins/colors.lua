return {
	{
		"bluz71/vim-moonfly-colors",
		config = function()
			-- vim.cmd.colorscheme("moonfly")
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		config = function()
			-- require("vscode").load("dark")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
			vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
		end,
	},
}
