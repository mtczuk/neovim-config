return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Flutter Run",
					program = "${workspaceFolder}/lib/main.dart", -- Path to your main.dart
					cwd = "${workspaceFolder}", -- Your Flutter project root
					flutter = true, -- Important: Tells the debugger it's a Flutter project
					args = {
						-- Add any Flutter run arguments here, e.g., "--flavor", "staging"
					},
				},
				{ -- For attaching to an already running process
					type = "dart",
					request = "attach",
					name = "Flutter Attach",
					flutter = true,
				},
			}

			-- Optional: Configure nvim-dap-virtual-text
			require("nvim-dap-virtual-text").setup()

			-- Key mappings (example)
			local map = vim.api.nvim_set_keymap
			local opt = { noremap = true, silent = true }
			map("n", "<F5>", ":DapContinue<CR>", opt)
			map("n", "<F10>", ":DapStepOver<CR>", opt)
			map("n", "<F11>", ":DapStepInto<CR>", opt)
			map("n", "<F12>", ":DapToggleBreakpoint<CR>", opt)
			map("n", "<Leader>dr", ":DapRestart<CR>", opt) -- Restart the debug session
			map("n", "<Leader>dl", ":DapLaunch<CR>", opt) -- Launch the debug session
			map("n", "<Leader>dq", ":DapTerminate<CR>", opt) -- Quit the debug session
			map("n", "<Leader>dt", ":DapToggleBreakpoint<CR>", opt) -- Toggle breakpoint
			map("n", "<Leader>dc", ":DapContinue<CR>", opt) -- Continue
			map("n", "<Leader>do", ":DapStepOver<CR>", opt) -- Step Over
			map("n", "<Leader>di", ":DapStepInto<CR>", opt) -- Step Into
			map("n", "<Leader>du", ":DapStepOut<CR>", opt) -- Step Out
			map("n", "<Leader>db", ":DapSetBreakpoint conditional<CR>", opt) -- Set conditional breakpoint
			map("n", "<Leader>de", ":DapEvaluate<CR>", opt) -- Evaluate expression
			map("n", "<Leader>dd", ":DapDisconnect<CR>", opt) -- Disconnect
			map("n", "<Leader>dh", ":DapHelp<CR>", opt) -- Help
		end,
	},
}
