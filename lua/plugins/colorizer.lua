-- Color previews for CSS, hex codes, etc.
-- https://github.com/norcalli/nvim-colorizer.lua

return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPost",
	opts = {
		"css",
		"scss",
		"html",
		"javascript",
		"typescript",
		"lua",
		"vim",
		"markdown",
		"*",
	},
}
