local function i(value)
  print(vim.inspect(value))
end

vim.keymap.set("n", "<leader>r", function()
  node = vim.treesitter.get_node()

  print(vim.inspect(getmetatable(node)))
end, { silent = true })

vim.api.nvim_create_user_command("RunPythonTest", function()
  i("foo")
end, {})
