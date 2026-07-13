-- Code outline/symbols sidebar
-- https://github.com/stevearc/aerial.nvim

return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>ca", "<cmd>AerialToggle!<CR>", desc = "[C]ode [A]erial outline" },
		{ "<leader>cs", "<cmd>AerialNavToggle<CR>", desc = "[C]ode [S]ymbols nav" },
		{ "gO", "<cmd>AerialToggle!<CR>", desc = "Toggle code outline" },
	},
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue", "go", "rust", "php", "lua", "json", "yaml" },
	opts = {
		backends = { "treesitter", "lsp" },
		layout = {
			min_width = 30,
			default_direction = "right",
		},
		attach_mode = "global",
		close_autocmds = { "VimEnter" },
	},
}
