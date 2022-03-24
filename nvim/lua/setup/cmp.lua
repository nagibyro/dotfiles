--Setup for nvim-cmp auto completion
local cmp = require("cmp")

cmp.setup {
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ["<c-space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },
  },

  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 5 },
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },

  -- formatting = {
  --   format = lspkind.cmp_format {
  --     with_text = true,
  --     menu = {
  --       buffer = "[buf]"
  --     }
  --   }
  -- }

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}
