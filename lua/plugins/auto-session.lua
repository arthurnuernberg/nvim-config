return {
	"rmagatti/auto-session",
	name = "session-restore",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/Downloads", "~/Documents", "~/Desktop/" },
		})
	end,
}
