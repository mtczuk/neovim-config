local function setup()
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local on_attach = function(client, bufnr)
		require("shared.setup_lsp_keymaps").execute(bufnr)
	end

	lspconfig.gopls.setup({
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
			},
		},
		capabilities = capabilities,
		on_attach = on_attach,
	})

	local mason_registry = require("mason-registry")
	local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
		.. "/node_modules/@vue/language-server"

	lspconfig.ts_ls.setup({
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = vue_language_server_path,
					languages = { "vue" },
				},
			},
		},
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig.eslint.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			eslint = {
				eslint = true,
				format = true,
				quiet = false,
				validate = "on",
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
				},
			},
		},
	})

	lspconfig.html.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig.graphql.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig.volar.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		init_options = {
			vue = {
				hybridMode = false,
			},
		},
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = {
			servers = {
				"graphql",
			},
		},
		config = setup,
	},
}
