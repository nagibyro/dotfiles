return {
  {
    -- parenthesis highlighting
    "utilyre/sentiment.nvim",
    version = "*",
    event = "VeryLazy", -- keep for lazy loading
    opts = {
      -- config
    },
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
    config = function()
      vim.api.nvim_set_hl(0, 'MatchParen', {
        bold=true,
        fg="#f44336",
        bg="Grey",
        cterm="bold"
      })
    end
  },

  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  }
}
