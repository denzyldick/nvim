-- Session management
-- https://github.com/rmagatti/auto-session

return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		auto_session_suppress_dirs = { "~", "~/", "~/Downloads", "/" },
		auto_save_enabled = true,
		auto_restore_enabled = true,
	},
}
