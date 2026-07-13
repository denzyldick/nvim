-- Edit filesystem as a buffer
-- https://github.com/stevearc/oil.nvim

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "-", function() require("oil").open_float() end, desc = "Oil: Open parent directory" },
	},
	opts = {
		default_file_explorer = false,
		columns = { "icon" },
		keymaps = {
			["<C-h>"] = "actions.select_split",
			["<C-v>"] = "actions.select_vsplit",
			["<C-t>"] = "actions.select_tab",
			["gq"] = "actions.close",
			["<leader>e"] = "actions.close",
		},
		view_options = {
			show_hidden = true,
		},
	},
}
