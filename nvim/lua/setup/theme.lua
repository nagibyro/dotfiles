--theme for neovim
local nightfox = require('nightfox')

nightfox.setup({
  fox = "nordfox",
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
})

nightfox.load()

