local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

-- local function close_nvim_tree()
--   local layout = vim.api.nvim_call_function("winlayout", {})
--   if layout[1] == "leaf"
--   and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
--   and layout[3] == nil then
--     vim.cmd("confirm quit")
--   end
-- end

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("UserNvimTreeOpen", { clear = true }),
  callback = open_nvim_tree
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("UserNvimTreeClose", { clear = true }),
--   callback = close_nvim_tree
-- })

require('nvim-tree').setup {
  update_cwd = true, --used for the project plugin to when switching projects
  update_focused_file = { --used for the project plugin to when switching projects
    enable = true,
    update_cwd = true,
  },
  git = {
    enable = true,
    ignore = false,
  },
  actions = {
    open_file = {
      resize_window = true,
      window_picker = {
        enable = false
      }
    }
  },
  renderer = {
    icons = {
      webdev_colors = true,
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      }
    },
    special_files = {
      "Cargo.toml",
      "Makefile",
      "README.md",
      "readme.md",
      "package.json",
      "package.lock",
      "poetry.lock",
      "pyproject.toml",
    },
  },
  view = {
    adaptive_size = true,
  }
}

-- interferes with telescope when trying to find a file with no files open
-- I think telescope buffer exits before it loads the file then this auto
-- command quits neovim. More research required
--
-- vim.api.nvim_exec([[
--   autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- ]], false)
