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
<<<<<<< Updated upstream
--   if layout[1] == "leaf"
--   and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
--   and layout[3] == nil then
--     vim.cmd("confirm quit")
--   end
-- end
=======
--   if
--       layout[1] == "leaf"
--       and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
--       and layout[3] == nil
--   then
--     vim.cmd("confirm quit")
--   end
-- end
---- nvim-tree is also there in modified buffers so this function filter it out
-- local modifiedBufs = function(bufs)
--   local t = 0
--   for k, v in pairs(bufs) do
--     if v.name:match("NvimTree_") == nil then
--       t = t + 1
--     end
--   end
--   return t
-- end
>>>>>>> Stashed changes

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("UserNvimTreeOpen", { clear = true }),
  callback = open_nvim_tree,
})

<<<<<<< Updated upstream
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("UserNvimTreeClose", { clear = true }),
--   callback = close_nvim_tree
=======
-- This doesn't play nice with telescope. I found for my workflow its common to
-- open a project at it's root using `vim .` then drop into telescope fuzzy
-- finder to open the file I want. The autoclose functionality messes with that
-- flow. As far as I can tell when you select a file in telescope it closes the
-- current buffer (the telescope window) and then opens a new buffer with the
-- file you picked. Problem seems to be that BufEnter fires when telescope
-- closes which sees that only NvimTree is open and so closes vim. I guess the
-- opening of the file from telescope is async in some way. so will need to
-- figure something else out here
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("UserNvimTreeClose", { clear = true }),
--   nested = true,
--   callback = function()
--     if
--         #vim.api.nvim_list_wins() == 1
--         and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
--         and modifiedBufs(vim.fn.getbufinfo({ bufmodified = 1 })) == 0
--     then
--       vim.cmd("quit")
--     end
--   end,
--   -- callback = close_nvim_tree,
>>>>>>> Stashed changes
-- })

require("nvim-tree").setup({
  update_cwd = true, --used for the project plugin to when switching projects
  update_focused_file = {
    --used for the project plugin to when switching projects
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
        enable = false,
      },
    },
  },
  renderer = {
    icons = {
      webdev_colors = true,
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
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
  },
})

-- interferes with telescope when trying to find a file with no files open
-- I think telescope buffer exits before it loads the file then this auto
-- command quits neovim. More research required
--
-- vim.api.nvim_exec([[
--   autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- ]], false)
