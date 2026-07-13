-- Markdown preview in browser with live reload
-- https://github.com/iamcco/markdown-preview.nvim

return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "[M]arkdown [P]review", silent = true },
	},
	opts = {
		mkdp_auto_start = false,
		mkdp_auto_close = true,
		mkdp_refresh_slow = false,
		mkdp_browser = "",
		mkdp_echo_preview_url = true,
		mkdp_browserfunc = "",
		mkdp_preview_options = {
			mkit = {},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = false,
			hide_yaml_meta = true,
		_sequence_diagrams = {},
			flowchart_diagrams = {},
			disable_filename = false,
		},
		mkdp_markdown_css = "",
		mkdp_highlight_css = "",
		mkdp_port = "",
		mkdp_page_title = "${name}",
		mkdp_filetypes = { "markdown" },
		mkdp_theme = "dark",
	},
}
