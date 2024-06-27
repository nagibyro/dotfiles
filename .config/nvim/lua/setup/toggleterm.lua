require("toggleterm").setup({
  open_mapping = [[<C-t>]],
  direction = "horizontal",
})

local function set_terminal_keymaps()
  local opts = { buffer = 0 }

  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<esc>", [[<C-\><C-n><C-w>]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true }),
  callback = set_terminal_keymaps,
  pattern = "term://*",
})
