return {
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
				ensure_installed = {
					"pyright",
					"ts_ls",
					"rust_analyzer",
					"eslint",
					"graphql",
					"volar",
					"lua_ls",
					"html",
				},
				automatic_installation = true,
			})
		end,
	},
}
