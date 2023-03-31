-- reference https://gist.github.com/VonHeikemen/8fc2aa6da030757a5612393d0ae060bd
--
--
-- This autocommand is invoked when lsp server is attached to the buffer
vim.api.nvim_create_autocmd("User", {
  pattern = "LspAttached",
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
    bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
    bufmap("n", "gr", require("telescope.builtin").lsp_references)
    bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
    bufmap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>")
    bufmap("n", "<C-l>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    bufmap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<cr>")
    bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
    bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
    bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
  end,
})

local python_util = require("python-utils")

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
  end,
}

local lspconfig = require("lspconfig")

lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
        maxPreload = 10000,
        preloadFileSize = 1000,
      },
    },
  },
})
lspconfig.yamlls.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.tsserver.setup({})
lspconfig.bashls.setup({})
lspconfig.eslint.setup({})
lspconfig.cssls.setup({})
lspconfig.dockerls.setup({})
lspconfig.html.setup({})
lspconfig.jsonls.setup({})
lspconfig.pyright.setup({
  on_init = function(client)
    client.config.settings.python.pythonPath = python_util.find_app_python(client.config.root_dir)
  end,
  settings = {
    pyright = {
      analysis = {
        useLibraryCodeForTypes = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        autoImportCompletions = true,
      },
    },
  },
})
lspconfig.awk_ls.setup({})
lspconfig.ansiblels.setup({})
lspconfig.sqlls.setup({})
lspconfig.esbonio.setup({})
lspconfig.svelte.setup({})
lspconfig.terraformls.setup({})
