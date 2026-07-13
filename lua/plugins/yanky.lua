-- Yank ring / clipboard history
-- https://github.com/gbprod/yanky.nvim

return {
	"gbprod/yanky.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	opts = {
		highlight = { timer = 250 },
		ring = { storage = "sqlite" },
	},
	keys = {
		{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank" },
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
		{ "<C-p>", "<Plug>(YankyPrevious)", desc = "Previous yank" },
		{ "<C-n>", "<Plug>(YankyNext)", desc = "Next yank" },
		{ "<leader>sy", function() require("telescope").extensions.yank_history.yank_history({}) end, desc = "[S]earch [Y]ank history" },
	},
}
