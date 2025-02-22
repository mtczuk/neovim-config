local M = {}

function M.setup()
	vim.opt.mouse = "a"

	vim.opt.clipboard = "unnamedplus"

	-- Basic settings
	vim.g.mapleader = " "
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.expandtab = true
	vim.opt.shiftwidth = 2
	vim.opt.tabstop = 2
	vim.opt.cursorline = true
	vim.opt.smartcase = true
	vim.opt.ignorecase = true -- Required for smartcase to work
	-- vim.opt.termguicolors = true

	vim.keymap.set("n", "z", "zz", { noremap = true, silent = true })
	vim.keymap.set("n", "<c-e>", "4<c-e>", { noremap = true, silent = true })
	vim.keymap.set("n", "<c-y>", "4<c-y>", { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })

	-- vim.keymap.set('t', '<c-n><c-c>', '<C-\\><C-n>')
	vim.keymap.set("t", "<C-[>", "<C-\\><C-n>")

	vim.keymap.set("n", "<C-j>", "4j", { noremap = true, silent = true })
	vim.keymap.set("n", "<C-k>", "4k", { noremap = true, silent = true })
	-- vim.keymap.set('n', 's', ':HopWord<CR>', { noremap = true, silent = true })

	vim.api.nvim_create_user_command("PwdCopy", function()
		vim.fn.setreg("+", vim.fn.getcwd())
		vim.notify("Current directory copied to clipboard!")
	end, {})

	vim.keymap.set("n", "s", function()
		require("hop").hint_char2()
	end, { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>s", function()
		require("hop").hint_char2()
	end, { noremap = true, silent = true })

	vim.keymap.set("v", "s", function()
		require("hop").hint_char2()
	end, { noremap = true, silent = true })

	vim.api.nvim_create_user_command("Reload", function()
		vim.cmd("source ~/.config/nvim/init.lua")
		print("Neovim config reloaded!")
	end, {})

	vim.api.nvim_set_keymap(
		"n",
		"<Leader>ds",
		":lua vim.diagnostic.open_float()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap("n", "<Leader>dn", ":lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Leader>dp", ":lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })

	vim.api.nvim_set_keymap("n", "tn", ":tabnew<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "tj", ":tabprevious<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "tk", ":tabnext<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "tl", ":tablast<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "th", ":tabfirst<CR>", { noremap = true, silent = true })

	vim.api.nvim_set_keymap("n", "<leader>bc", ":bp|bd #<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>bp", ":bp<CR>", { noremap = true, silent = true })
end

return M
