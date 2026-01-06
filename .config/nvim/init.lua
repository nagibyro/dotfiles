local python_utils = require("utils.python")
vim.g.python3_host_prog = python_utils.find_host_python()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = "," --lazy needs leader key before running setup

require("user.options")
require("user.mappings")
require("lazy").setup("plugins")

vim.api.nvim_set_hl(0, "MatchParen", {
	bold = true,
	fg = "#f44336",
	bg = "Grey",
})

--fix terraform and hcl comment string
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
	callback = function(ev)
		vim.bo[ev.buf].commentstring = "# %s"
	end,
	pattern = { "terraform", "hcl" },
})
