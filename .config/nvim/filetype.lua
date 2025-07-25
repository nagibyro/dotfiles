vim.g.do_filetype_lua = 1

vim.filetype.add({
	extension = {
		env = "dotenv",
		tf = "terraform",
	},

	filename = {
		[".env"] = "dotenv",
		["env"] = "dotenv",
		["tsconfig.json"] = "jsonc",
	},

	pattern = {
		["%.env%.[%w_.-]+"] = "dotenv", -- Match filenames like ".env.example", ".env.local" etc...
	},
})

vim.filetype.add({
	extension = {
		ghaction = "ghaction",
	},

	pattern = {
		[".*%.github/workflows/.*%.ya?ml"] = "ghaction",
		[".*%.github/actions/.*%.ya?ml"] = "ghaction",
	},
})
