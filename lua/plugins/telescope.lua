local M = {}

function M.setup()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			file_ignore_patterns = {
				"node_modules",
				".git",
				"target",
				"dist",
				".dart_tool",
				"android",
				"build",
				"ios",
				"web",
			},
			path_display = { "truncate" },
		},
		pickers = {
			find_files = {
				hidden = true,
			},
		},
	})

	-- Telescope keymaps
	local builtin = require("telescope.builtin")

	vim.keymap.set("n", "<leader>ff", builtin.find_files)
	vim.keymap.set("n", "<leader>fg", builtin.live_grep)
	vim.keymap.set("n", "<leader>fb", builtin.buffers)
	vim.keymap.set("n", "<leader>fh", builtin.help_tags)
	vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
	vim.keymap.set("n", "<leader>fj", function()
		require("neogit").open({ kind = "floating" })
	end)
end

return M
