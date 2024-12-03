local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.build = (function()
	return "make install_jsregexp"
end)()

ls.config.set_config({
	-- Jump back into snippet if you make a mistake
	history = true,

	-- allow us to see text change in real time
	updateevents = "TextChanged,TextChangedI",

	enable_autosnippets = true,
})

require("luasnip.loaders.from_vscode").lazy_load()
ls.filetype_extend("python", { "django" })

------------ Keymaps -----------------
-- ctrl-j is the expansion key
-- expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- ctrl-k is the jump backwards key
-- moves to a previous item in the snippet
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- ctrl-l list of options
vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })
