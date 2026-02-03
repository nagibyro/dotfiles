local M = {}

-- modify any lsp config value under "settings"
-- Note this only works on lsp servers that support workspace/didChangeConfiguration
-- So not jedi_language_server FYI
-- @param server_name string|table: LSP server name, or a client object
-- @param settings_patcher function: Function that takes current settings and returns changes to merge
function M.patch_lsp_settings(server_name, settings_patcher)
	local function patch_settings(client)
		local changed_settings = settings_patcher(client.config.settings)
		client.config.settings = vim.tbl_deep_extend("force", client.config.settings, changed_settings)
		client.notify("workspace/didChangeConfiguration", {
			settings = client.config.settings,
		})
	end

	-- If server_name is a client object (e.g., from on_attach), use it directly
	if type(server_name) == "table" and server_name.id and server_name.config then
		patch_settings(server_name)
		return
	end

	-- Otherwise, find clients by name
	local clients = vim.lsp.get_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = server_name,
	})

	for _, client in ipairs(clients) do
		patch_settings(client)
	end
end

return M
