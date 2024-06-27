local null_ls = require("null-ls")
local python_utils = require("python-utils")
local lsp_util = require("lspconfig/util")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.formatting.codespell,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.pylint.with({
      -- assuming the command is in a virtual env for now
      command = lsp_util.path.join(python_utils.find_app_python_bin(), "pylint") or "pylint",
      timeout = 20000, --milliseconds
      --
      -- Prefer_local appends to the end of the CWD
      -- so doesn't work if the venv is outside the
      -- project probably need dynamic_command for this but that is a bit more
      -- work to implement. Probably need to follow something like https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/helpers/command_resolver.lua#L46-L83 -- to make it work
      -- dynamic_command = function(params)
      -- end
    }),
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.diagnostics.terraform_validate,
    null_ls.builtins.formatting.autoflake.with({
      extra_args = {
        "--remove-all-unused-imports",
        "--remove-unused-variables",
        "--ignore-init-module-imports",
        "--ignore-pass-statements",
      },
    }),
    -- null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort.with({
      command = lsp_util.path.join(python_utils.find_app_python_bin(), "isort") or "isort",
    }),
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.terraform_fmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
