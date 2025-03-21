local function setup() end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-live-grep-args.nvim" },
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						".git",
					},
					path_display = { "truncate" },
				},
				pickers = {
					find_files = {
						hidden = false,
					},
				},
			})

			telescope.load_extension("live_grep_args")

			-- Telescope keymaps
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep)
			vim.keymap.set("n", "<leader>fb", builtin.buffers)
			vim.keymap.set("n", "<leader>fc", builtin.help_tags)
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
			vim.keymap.set("n", "<leader>fx", function()
				require("neogit").open({ kind = "floating" })
			end)
		end,
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<leader>fl", function()
				require("harpoon.mark").add_file()
			end)

			vim.keymap.set("n", "<leader>fh", function()
				require('harpoon.ui').toggle_quick_menu()
			end)

			vim.keymap.set("n", "<leader>fj", function()
				require('harpoon.ui').nav_next()
			end)

			vim.keymap.set("n", "<leader>fk", function()
				require('harpoon.ui').nav_prev()
			end)
		end,
	},
}
