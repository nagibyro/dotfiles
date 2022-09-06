local M = {}

local lsp_util = require('lspconfig/util')

function M.get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return lsp_util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv from poetry in workspace directory.
  local matchPoetry = vim.fn.glob(lsp_util.path.join(workspace, 'poetry.lock'))
  if matchPoetry ~= '' then
    local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
    return lsp_util.path.join(venv, 'bin', 'python');
  end


  -- Find and use virtualenv from pipenv in workspace directory.
  local matchPip = vim.fn.glob(lsp_util.path.join(workspace, 'Pipfile'))
  if matchPip ~= '' then
    local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. matchPip .. ' pipenv --venv'))
    return lsp_util.path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

return M
