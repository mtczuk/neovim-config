return {
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({
				widget_guides = {
					enabled = true,
				},
				lsp = {
					on_attach = function(client, bufnr)
						require("shared.setup_lsp_keymaps").execute(bufnr)
					end,
				},
			})
		end,
	},
}
