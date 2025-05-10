local function setup() end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-live-grep-args.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local action_state = require("telescope.actions.state")
			local actions = require("telescope.actions")

			-- https://medium.com/@jogarcia/delete-buffers-on-telescope-21cc4cf61b63
			buffer_searcher = function()
				builtin.buffers({
					sort_mru = true,
					ignore_current_buffer = true,
					show_all_buffers = false,
					attach_mappings = function(prompt_bufnr, map)
						local refresh_buffer_searcher = function()
							actions.close(prompt_bufnr)
							vim.schedule(function()
								buffer_searcher()
								vim.api.nvim_input("<Esc>")
							end)
						end

						local delete_buf = function()
							local selection = action_state.get_selected_entry()
							vim.api.nvim_buf_delete(selection.bufnr, { force = true })
							refresh_buffer_searcher()
						end

						local delete_multiple_buf = function()
							local picker = action_state.get_current_picker(prompt_bufnr)
							local selection = picker:get_multi_selection()
							for _, entry in ipairs(selection) do
								vim.api.nvim_buf_delete(entry.bufnr, { force = true })
							end
							refresh_buffer_searcher()
						end

						map("n", "dd", delete_buf)

						return true
					end,
				})
			end

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
			vim.keymap.set("n", "<leader>fb", buffer_searcher, {})
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
			vim.api.nvim_create_autocmd("TextChangedI", {
				pattern = "*.dart",
				callback = function()
					require("harpoon.mark").add_file()
				end,
			})

			vim.keymap.set("n", "<C-l>", function()
				require("harpoon.mark").add_file()
			end)

			vim.keymap.set("n", "<C-h>", function()
				require("harpoon.ui").toggle_quick_menu()
			end)

			vim.keymap.set("n", "<C-j>", function()
				require("harpoon.ui").nav_next()
			end)

			vim.keymap.set("n", "<C-k>", function()
				require("harpoon.ui").nav_prev()
			end)

			require("harpoon").setup({
				menu = {
					width = vim.api.nvim_win_get_width(0) - 4,
				},
			})
		end,
	},
}
