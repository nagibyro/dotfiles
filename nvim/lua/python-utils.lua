local M = {}


--
-- Relying on lspconfig/utils is bad here since on a fresh nvim install we have
-- not installed lspconfig via packer but we call python utils in nvim setup
-- which will error because lspconfig is not installed. So bit of a chicken and
-- egg problem here.
--
-- Temp workaround comment out lsp_util require and comment out everything in
-- find_app_python till fallback to system python. Get Packer installed and Run
-- sync then uncomment everything. (sucks I know)
--

local lsp_util = require('lspconfig/util')

function M.find_app_python(workspace)
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

function M.find_host_python()
  local neovimVenv = vim.fn.expand("~/venv/neovim")

  if vim.fn.isdirectory(neovimVenv) then
    return neovimVenv .. "/bin/python"
  else
    vim.g.pyton3_host_prog = vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
  end
end

return M
