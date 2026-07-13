-- Advanced TypeScript support (replaces ts_ls)
-- https://github.com/pmizio/typescript-tools.nvim

return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
	opts = {
		settings = {
			ts_ls_path = nil,
			tsserver_max_memory = 256,
			-- Language features
			complete_function_calls = true,
			include_completions_with_insert_text = true,
			-- Inlay hints
			tsserver_inlay_hints = {
				enabled = true,
				include_inlay_parameter_name_hints = "all",
				include_inlay_function_parameter_type_hints = true,
				include_inlay_variable_type_hints = true,
				include_inlay_property_declaration_type_hints = true,
				include_inlay_function_like_return_type_hints = true,
				include_inlay_enum_member_value_hints = true,
			},
			-- Code lens
			tsserver_code_lens = "all",
			-- Formatting (disabled since we use conform.nvim with prettier)
			jsx_close_tag = {
				enabled = true,
				filetypes = { "javascriptreact", "typescriptreact", "vue" },
			},
		},
	},
	keys = {
		{ "<leader>to", "<cmd>TSToolsOrganizeImports<CR>", desc = "[T]S [O]rganize imports" },
		{ "<leader>ti", "<cmd>TSToolsAddMissingImports<CR>", desc = "[T]S add [I]mports" },
		{ "<leader>tr", "<cmd>TSToolsRenameFile<CR>", desc = "[T]S [R]ename file + imports" },
		{ "<leader>tf", "<cmd>TSToolsFixAll<CR>", desc = "[T]S [F]ix all diagnostics" },
		{ "<leader>tu", "<cmd>TSToolsRemoveUnusedImports<CR>", desc = "[T]S remove [U]nused imports" },
		{ "<leader>ts", "<cmd>TSToolsSortImports<CR>", desc = "[T]S [S]ort imports" },
		{ "<leader>tc", "<cmd>TSToolsFiletypeCommand<CR>", desc = "[T]S file [C]ommand" },
	},
}
