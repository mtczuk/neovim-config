return {
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			local prettier = { "prettierd", "prettier", stop_after_first = true }

			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					dart = { lsp_format = "prefer" },
					go = { lsp_format = "prefer" },
					javascript = prettier,
					javascriptreact = prettier,
					typescript = prettier,
					typescriptreact = prettier,
					vue = prettier,
					graphql = prettier,
					html = prettier,
				},
			})

			vim.api.nvim_create_user_command("Format", function(args)
				require("conform").format({ bufnr = args.buf })
			end, {})

			vim.api.nvim_set_keymap("n", "<leader>fm", ":Format<CR>", { noremap = true, silent = true })
		end,
	},
}
