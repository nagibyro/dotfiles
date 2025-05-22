local utils = require("utils")
local M = {}

local function replace_slashes(path)
	local path = vim.fn.substitute(path, "/", ".", "g")
	path = vim.fn.substitute(path, "\\", ".", "g")
	path = vim.fn.trim(path, ".", 1)

	return path
end

function M.find_app_python_simple()
	-- going to need to merge this with find_app_python at some point
	if vim.env.VIRTUAL_ENV then
		return vim.env.VIRTUAL_ENV .. "/bin/python"
	end

	-- Fallback to system Python.
	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

function M.find_django_manage(filepath) end

function M.get_import_path(filepath)
	---  test out this function by running lua in the command prompt
	-- :lua vim.print(vim.inspect(require('python-utils').get_import_path(vim.fn.expand("~/projects/test/folder/path/test.py"))))
	local path = vim.fn.fnamemodify(filepath, ":.:r")

	local top_level_module = vim.fn.fnamemodify(filepath, ":h")

	local recursive_check = 100

	while vim.fn.filereadable(vim.fn.findfile("__init__.py", top_level_module)) ~= 0 and recursive_check > 0 do
		if top_level_module == "." or top_level_module == "/" then
			return replace_slashes(path)
		end

		top_level_module = vim.fn.fnamemodify(top_level_module, ":h")
		recursive_check = recursive_check - 1
	end

	path = vim.fn.substitute(path, top_level_module, "", "")
	return replace_slashes(path)
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

function M.venv_has(cmd)
	if not vim.env.VIRTUAL_ENV then
		return false
	end

	local cmd_path = vim.env.VIRTUAL_ENV .. "/bin/" .. cmd

	return utils.file_exists(cmd_path)
end

return M
