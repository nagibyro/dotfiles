vim.g.do_filetype_lua = 1

vim.filetype.add({
  extension = {
    es6 = "javascript",
  },
})

vim.filetype.add({
  extension = {
    tf = "hcl",
  },
})

vim.filetype.add({
  extension = {
    html = function()
      if vim.env.VIRTUAL_ENV then
        return "htmldjango"
      else
        return "html"
      end
    end,
  },
})
