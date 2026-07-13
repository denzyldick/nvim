-- Pretty list for diagnostics, references, quickfix, etc.
-- https://github.com/folke/trouble.nvim

return {
	"folke/trouble.nvim",
	cmd = { "Trouble", "TroubleToggle" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "[X] Diagnostics (Trouble)" },
		{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "[X] Buffer diagnostics" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "[X] Quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "[X] Location list" },
		{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "[X] Document symbols" },
	},
	opts = {},
}
