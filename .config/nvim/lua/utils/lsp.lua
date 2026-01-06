local M = {}

-- modify any lsp config value under "settings"
-- Note this only works on lsp servers that support workspace/didChangeConfiguration
-- So not jedi_language_server FYI
function M.patch_lsp_settings(server_name, settings_patcher)
	local function patch_settings(client)
		local changed_settings = settings_patcher(client.config.settings)
		client.config.settings = vim.tbl_deep_extend("force", client.config.settings, changed_settings)
		client.notify("workspace/didChangeConfiguration", {
			settings = client.config.settings,
		})
	end

	local clients = vim.lsp.get_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = server_name,
	})

	for _, client in ipairs(clients) do
		patch_settings(client)
	end
end

return M
