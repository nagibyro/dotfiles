--theme for neovim
local nightfox = require('nightfox')

nightfox.setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      functions = "italic,bold"
    },
    inverse = {
      visual = true,
      search = true,
      match_paren = true,
    }
  }
})

vim.cmd("colorscheme nightfox")
