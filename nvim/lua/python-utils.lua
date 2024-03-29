local M = {}


function M.find_app_python_bin()
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. "/bin"
  end

  return nil
end

function M.find_app_python(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. "/bin/python"
  end

  -- Find and use virtualenv from poetry in workspace directory.
  local matchPoetry = vim.fn.glob(workspace .. "/poetry.lock")
  if matchPoetry ~= "" then
    local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
    return venv .. "/bin/python"
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  -- local matchPip = vim.fn.glob(lsp_util.path.join(workspace, "Pipfile"))
  -- if matchPip ~= "" then
  --   local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. matchPip .. " pipenv --venv"))
  --   return lsp_util.path.join(venv, "bin", "python")
  -- end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

function M.find_host_python()
  local neovimVenv = vim.fn.expand("~/venv/neovim")

  if vim.fn.isdirectory(neovimVenv) then
    return neovimVenv .. "/bin/python"
  else
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
  end
end

return M
