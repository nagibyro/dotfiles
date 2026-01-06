-- ref https://github.com/alpha2phi/neovim-for-beginner/blob/17-vimspector/lua/utils/init.lua

local M = {}

function M.warn(msg, name)
	vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
	vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
	vim.notify(msg, vim.log.levels.INFO, { title = name })
end

function M.file_exists(path)
	local stat = vim.uv.fs_stat(path)
	return stat and true or false
end

return M
