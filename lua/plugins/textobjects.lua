-- Treesitter text objects (if/af/ic/ac for functions, classes, etc.)
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	lazy = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "around function" },
						["if"] = { query = "@function.inner", desc = "inside function" },
						["ac"] = { query = "@class.outer", desc = "around class" },
						["ic"] = { query = "@class.inner", desc = "inside class" },
						["aa"] = { query = "@parameter.outer", desc = "around parameter" },
						["ia"] = { query = "@parameter.inner", desc = "inside parameter" },
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = { query = "@function.outer", desc = "next function start" },
						["]c"] = { query = "@class.outer", desc = "next class start" },
					},
					goto_previous_start = {
						["[f"] = { query = "@function.outer", desc = "prev function start" },
						["[c"] = { query = "@class.outer", desc = "prev class start" },
					},
				},
			},
		})
	end,
}
