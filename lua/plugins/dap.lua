return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dapgo = require("dap-go")

			dapui.setup()
			dapgo.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>gt", function()
				dapui.toggle()
			end)

			vim.keymap.set("n", "<leader>gb", function()
				dap.toggle_breakpoint()
			end)

			vim.keymap.set("n", "<leader>gc", function()
				dap.continue()
			end)

			vim.keymap.set("n", "<leader>gi", function()
				dap.step_into()
			end)

			vim.keymap.set("n", "<leader>go", function()
				dap.step_over()
			end)

			vim.keymap.set("n", "<leader>gr", function()
				dap.repl.open()
			end)

			vim.api.nvim_create_user_command("DapStopOnExceptions", function()
				dap.set_exception_breakpoints("default")
			end, {})

			vim.api.nvim_create_user_command("DapIgnoreExceptions", function()
				dap.set_exception_breakpoints({})
			end, {})

			vim.api.nvim_set_keymap("n", "<leader>gl", ":e .vscode/launch.json<CR>", { noremap = true, silent = true })

			dap.adapters.go = {
				type = "executable",
				command = "node",
				args = { os.getenv("VSCODE_GO") },
			}
			dap.configurations.go = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					showLog = false,
					program = "${file}",
					dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
				},
			}

			dap.adapters.dart = {
				type = "executable",
				-- As of this writing, this functionality is open for review in https://github.com/flutter/flutter/pull/91802
				command = "flutter",
				args = { "debug_adapter" },
			}
			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Launch Flutter Program",
					-- The nvim-dap plugin populates this variable with the filename of the current buffer
					program = "${file}",
					-- The nvim-dap plugin populates this variable with the editor's current working directory
					cwd = "${workspaceFolder}",
					-- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
					-- toolArgs = { "-d", "linux" },
				},
				{
					type = "dart",
					request = "attach",
					name = "Attach Flutter Program",
					-- The nvim-dap plugin populates this variable with the filename of the current buffer
					program = "${file}",
					-- The nvim-dap plugin populates this variable with the editor's current working directory
					cwd = "${workspaceFolder}",
					-- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
					-- toolArgs = { "-d", "linux" },
				},
			}

			--[[
			dap.adapters.dart = {
				type = "executable",
				command = "dart",
				-- This command was introduced upstream in https://github.com/dart-lang/sdk/commit/b68ccc9a
				args = { "debug_adapter" },
			}
			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Launch Dart Program",
					-- The nvim-dap plugin populates this variable with the filename of the current buffer
					program = "${file}",
					-- The nvim-dap plugin populates this variable with the editor's current working directory
					cwd = "${workspaceFolder}",
					args = { "--help" }, -- Note for Dart apps this is args, for Flutter apps toolArgs
				},
			}
      --]]
		end,
	},
}
