-- debug.lua
--
-- Debugging configuration for all supported languages:
--   Go:     delve (via nvim-dap-go)
--   Rust:   codelldb (via mason-nvim-dap)
--   JS/TS:  vscode-js-debug (via mason-nvim-dap)
--   PHP:    php-debug (via mason-nvim-dap)
--
-- Keymaps:
--   <F5>     Start/Continue
--   <F1>     Step Into
--   <F2>     Step Over
--   <F3>     Step Out
--   <F7>     Toggle DAP UI
--   <leader>db  Toggle breakpoint
--   <leader>dB  Set conditional breakpoint

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mason-org/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
	},
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "[D]ebug: Start/Continue",
		},
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
			desc = "[D]ebug: Step Into",
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
			desc = "[D]ebug: Step Over",
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
			desc = "[D]ebug: Step Out",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "[D]ebug [B]reakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "[D]ebug [B]reakpoint (conditional)",
		},
		{
			"<F7>",
			function()
				require("dapui").toggle()
			end,
			desc = "[D]ebug: Toggle UI",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Mason DAP: auto-installs debug adapters
		--   To add a new debug adapter, add it to ensure_installed below
		--   Run :Mason to see available adapters
		require("mason-nvim-dap").setup({
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				"delve", -- Go
				"codelldb", -- Rust
				"js-debug-adapter", -- JavaScript / TypeScript
				"php-debug-adapter", -- PHP
			},
		})

		-- DAP UI setup
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Auto-open/close DAP UI on debug events
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Go DAP configuration (delve)
		require("dap-go").setup({
			delve = { detached = vim.fn.has("win32") == 0 },
		})

		-- JavaScript/TypeScript DAP configuration (pwa-node)
		--   Uses js-debug-adapter installed via mason
		--   To debug: set a breakpoint, press F5, select "Launch file"
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "127.0.0.1",
			port = "${port}",
			executable = {
				command = "js-debug-adapter",
				args = { "${port}" },
			},
		}
		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end

		-- Rust DAP configuration (codelldb)
		dap.adapters["codelldb"] = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
			},
		}
		dap.configurations.rust = {
			{
				name = "Launch (codelldb)",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to binary: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- PHP DAP configuration (php-debug)
		--   Requires Xdebug to be installed and configured in PHP
		--   Default port: 9003
		dap.adapters.php = {
			type = "executable",
			command = "php-debug-adapter",
			args = {},
		}
		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
				pathMappings = {
					["/var/www/html"] = "${workspaceFolder}",
				},
			},
		}
	end,
}
