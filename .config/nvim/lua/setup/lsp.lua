local python_util = require("python-utils")

--local client_capabilities = vim.lsp.protocol.make_client_capabilities()
--client_capabilities.textDocument.completionItem.snippetSupport = true
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.declaration()
    end, opts)
    vim.keymap.set("n", "gi", function()
      vim.lsp.buf.implementation()
    end, opts)
    vim.keymap.set("n", "go", function()
      vim.lsp.buf.type_definition()
    end, opts)
    vim.keymap.set("n", "gr", function()
      require("telescope.builtin").lsp_references()
    end, opts)
    vim.keymap.set("n", "<C-k>", function()
      vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("n", "<leader>cr", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("n", "<C-l>", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>cf", function()
      vim.lsp.buf.format()
    end, opts)
    vim.keymap.set("x", "<F4>", function()
      vim.lsp.buf.range_code_action()
    end, opts)
    vim.keymap.set("n", "gl", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_next()
    end, opts)
  end,
}

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({})
local lspconfig = require("lspconfig")

lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
      },
      format = {
        enable = true,
        bracketSpacing = true,
      },
      validate = true,
    },
    keyOrdering = false,
  },
})
lspconfig.tsserver.setup({})
lspconfig.bashls.setup({})
lspconfig.eslint.setup({})
lspconfig.cssls.setup({})
lspconfig.dockerls.setup({})
lspconfig.html.setup({
  filetypes = { "html", "htmldjango" },
})
lspconfig.jsonls.setup({})
lspconfig.jedi_language_server.setup({})
-- lspconfig.pyright.setup({
--   on_init = function(client)
--     client.config.settings.python.pythonPath = python_util.find_app_python(client.config.root_dir)
--   end,
--   settings = {
--     pyright = {
--       disableLanguageServices = true,
--       disableOrganizeImports = true,
--       analysis = {
--         typeCheckingMode = "off",
--         useLibraryCodeForTypes = false,
--         autoSearchPaths = true,
--         diagnosticMode = "openFilesOnly",
--         autoImportCompletions = true,
--         stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
--       },
--     },
--   },
-- })
lspconfig.awk_ls.setup({})
lspconfig.ansiblels.setup({})
lspconfig.sqlls.setup({})
lspconfig.esbonio.setup({})
lspconfig.svelte.setup({})
lspconfig.terraformls.setup({})
-- lspconfig.emmet_language_server.setup({})
-- lspconfig.ruff_lsp.setup({})
