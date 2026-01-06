return {
	{
		"olimorris/codecompanion.nvim",
		opts = {
			adapters = {
				http = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = "cmd:op read op://dev/claude_api_key/credential --no-newline",
							},
						})
					end,
				},
				acp = {
					claude_code = function()
						return require("codecompanion.adapters").extend("claude_code", {
							env = {
								CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",
							},
						})
					end,
				},
			},
			strategies = {
				chat = {
					adapter = "claude_code",
				},
				inline = {
					adapter = "claude_code",
				},
				agent = {
					adapter = "claude_code",
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
