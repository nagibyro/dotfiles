require('nvim-tree').setup {
  update_cwd = true, --used for the project plugin to when switching projects
  update_focused_file = { --used for the project plugin to when switching projects
    enable = true,
    update_cwd = true,
  },
  open_on_setup = true,
  git = {
    ignore = false,
  },
}

-- interferes with telescope when trying to find a file with no files open
-- I think telescope buffer exits before it loads the file then this auto
-- command quits neovim. More research required
--
-- vim.api.nvim_exec([[
--   autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- ]], false)
