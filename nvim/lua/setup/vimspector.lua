-- reference
-- https://alpha2phi.medium.com/neovim-for-beginners-debugging-using-vimspector-3b6762dbd115

local M = {}

local vimspector_python = [[
{
  "configurations": {
    "<name>: Launch": {
      "adapter": "debugpy",
      "configuration": {
        "name": "Python: Launch",
        "type": "python",
        "request": "launch",
        "python": "%s",
        "stopOnEntry": true,
        "console": "externalTerminal",
        "debugOptions": [],
        "program": "${file}"
      }
    }
  }
}
]]

local python_utils = require('python-utils')
local utils = require('utils')

local function debuggers()
  vim.g.vimspector_install_gadgets = {
    "debugpy", -- Python
  }
end

-- Generate a basic debug profile
function M.generate_debug_profile()
  -- Get current file type
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")

  if ft == "python" then

    -- see :help file-search for finddir format
    -- basically we put a stop on the recursive serach not to go higher than
    -- home
    local homeDir = vim.fn.expand("~")
    local workspace_dir = vim.fn.finddir(string.format('.git/..;%s', homeDir))

    local python3 = python_utils.get_python_path(workspace_dir)

    local debug_profile = string.format(vimspector_python, python3)

    --Generate debug profile in a new window
    vim.api.nvim_exec("vsp", true)
    local win = vim.api.nvim_get_current_win()
    local buf_new = vim.api.nvim_create_buf(true, false)

    vim.api.nvim_buf_set_name(buf_new, ".vimspector.json")
    vim.api.nvim_win_set_buf(win, buf_new)

    local lines = {}
    for s in debug_profile:gmatch "[^\r\n]+" do
      table.insert(lines, s)
    end

    vim.api.nvim_buf_set_lines(buf_new, 0, -1, false, lines)
  else
    utils.info("Unsupported language -- " .. ft, "Generate Debug Profile")
  end
end

function M.toggle_human_mode()
  if vim.g.vimspector_enable_mappings == nil then
    vim.g.vimspector_enable_mappings = "HUMAN"
    utils.info("Enabled HUMAN mappings", "Debug")
  else
    vim.g.vimspector_enable_mappings = nil
    utils.info("Disabled HUMAN mappings", "Debug")
  end
end

function M.setup()
  vim.cmd [[packadd! vimspector]] --load vimspector
  debuggers()
end

return M

