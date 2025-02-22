local function setup()
	local neotree = require("neo-tree")
	neotree.setup({
		event_handlers = {
			{
				event = "neo_tree_buffer_enter",
				handler = function(arg)
					vim.cmd([[
            setlocal relativenumber
          ]])
				end,
			},
		},
		filesystem = {
			follow_current_file = { enabled = false, leave_dirs_open = false },
		},
		buffers = {
			follow_current_file = { enabled = true, leave_dirs_open = false },
		},
		default_component_configs = {
			file_size = { enabled = false },
			type = { enabled = false },
			last_modified = { enabled = false },
			created = { enabled = false },
			symlink_target = { enabled = false },
		},
	})

	vim.keymap.set("n", "<leader>tf", ":Neotree reveal_force_cwd<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", "\\", ":Neotree toggle<CR>", { noremap = true, silent = true })
end

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = setup,
	},
}
