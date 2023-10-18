vim.g.do_filetype_lua = 1

vim.filetype.add({
  extension = {
    es6 = "javascript",
    env = "dotenv",
  },

  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
    ["tsconfig.json"] = "jsonc",
  },

  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv", -- Match filenames like ".env.example", ".env.local" etc...
  },

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
