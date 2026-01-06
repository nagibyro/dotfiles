require("lualine").setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "filetype" },
		lualine_y = {
			{
				"datetime",
				style = "%A, %B %d | %I:%M %p",
			},
		},
		lualine_z = { "location" },
	},
	-- options = {
	--   icons_enabled = false,
	--   -- theme = false,
	--   compo = false,
	--   icons_enabled = false,

	-- }
})
