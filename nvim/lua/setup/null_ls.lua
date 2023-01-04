local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.formatting.codespell,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.formatting.autoflake,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.stylelua,
  }
})
