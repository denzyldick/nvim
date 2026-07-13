-- Managed terminal windows
-- https://github.com/akinsho/toggleterm.nvim

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" },
		{ "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", desc = "[T]oggle [T]erminal" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal size=12<CR>", desc = "[T]oggle [H]orizontal terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "[T]oggle [V]ertical terminal" },
	},
	opts = {
		open_mapping = false,
		direction = "float",
		float_opts = {
			border = "curved",
		},
	},
}
