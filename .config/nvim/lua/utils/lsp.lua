local M = {}

-- modify any lsp config value under "settings"
-- Note this only works on lsp servers that support workspace/didChangeConfiguration
-- So not jedi_language_server FYI
function M.patch_lsp_settings(server_name, settings_patcher)
  local function patch_settings(client)
    client.config.settings = settings_patcher(client.config.settings)
    client.notify("workspace/didChangeConfiguration", {
      settings = client.config.settings,
    })
  end

  local clients = vim.lsp.get_active_clients({ name = server_name })
  if #clients > 0 then
    patch_settings(clients[1])
    return
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    once = true,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.name == server_name then
        patch_settings(client)
        return true
      end
    end,
  })
end

return M
