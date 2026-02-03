# NeoVim Config

Contains all neovim config. Majority if not all config should be in lua. see
[nvim-lua-guide](https://github.com/nanotee/nvim-lua-guide) for documentation on
using lua with NeoVim.

## NeoVim config inspirations

- Ben Frain [init.lua gist](https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f)
  - His [youtube](https://www.youtube.com/channel/UC6UnOs9NSiyVjsemVX30KCA) has some good videos as well 
- TJ DeVries [youtube](https://www.youtube.com/c/TJDeVries) a lot of good
  indepth explanations for neovim
  - His neovim [config](https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/init.lua) is very good and well commented.

# Plugin Installation
I use [lazy.nvim](https://github.com/folke/lazy.nvim) to manage
my plugins. Invoking neovim will auto install lazy.nvim

## Plugin System Dependencies
TODO: automate installing system dependencies.

### List of Required System Dependencies
- LSP language servers see [lsp server configurations](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- Ripgrep for [ripgrep plugin](https://github.com/BurntSushi/ripgrep#installation)
- [fd](https://github.com/sharkdp/fd#installation)
- A patched [Nerdfont](https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e)

### Create a python venv in home
Vimspector (debug plugin) and other functionality relies on a python install
with the neovim package installed to talk to neovim API's. Best to keep this
seperate from the main system python so stuff doesn't get screwed up.

1. `python -m venv $HOME/venv/neovim`
2. `cd $HOME/venv && source bin/activate`
3. `pip install neovim`
4. `exit`

the `find_host_python` function in `mappings.lua` will use this venv by default
to set the `vim.g.python3_host_prog`

## Neovim LSP Diagnostics: How They Work
### The Diagnostic Flow

1. **LSP client starts**: When you open a file, lspconfig spawns the language server and creates a Neovim LSP client.

2. **Server sends diagnostics**: The language server analyzes your code and sends a `textDocument/publishDiagnostics` JSON-RPC notification to Neovim containing diagnostic messages.

3. **Handler receives the notification**: Neovim's default handler at `vim.lsp.handlers["textDocument/publishDiagnostics"]` receives the notification. This calls `vim.lsp.diagnostic.on_publish_diagnostics()` which:
   - Converts LSP diagnostic format to `vim.diagnostic` format
   - Gets/creates a namespace for that client via `vim.lsp.diagnostic.get_namespace(client_id)`
   - Stores diagnostics via `vim.diagnostic.set(namespace, bufnr, diagnostics)`

4. **Diagnostics are stored**: After `vim.diagnostic.set()`, the diagnostics are stored in Neovim's internal cache, queryable via `vim.diagnostic.get()`.

5. **Display is triggered**: Based on `vim.diagnostic.config()`, Neovim renders virtual text, signs, and underlines.

### Key Functions

| Function | Purpose |
|----------|---------|
| `vim.lsp.diagnostic.on_publish_diagnostics()` | Default handler that processes incoming LSP diagnostics |
| `vim.lsp.diagnostic.get_namespace(client_id)` | Gets/creates a unique namespace for an LSP client |
| `vim.diagnostic.set(ns, bufnr, diagnostics)` | Stores diagnostics in Neovim's cache |
| `vim.diagnostic.get(bufnr)` | Retrieves stored diagnostics |
| `vim.diagnostic.enable(bool, {ns_id = ...})` | Controls display only, not storage |
| `vim.diagnostic.get_namespaces()` | Lists all registered diagnostic namespaces |

### Important Distinction

`vim.diagnostic.enable(false, {ns_id = ...})` only controls **display** (virtual text, signs, underlines). The diagnostics are still stored and returned by `vim.diagnostic.get()`. This means plugins like trouble.nvim and statusline components will still see them.

To prevent diagnostics from being stored at all, you must intercept them at the handler level before `vim.diagnostic.set()` is called.

At first I tried just making sure they didn't display via the LSP however it
turns out that many other plugins use vim.diagnostics.get() to display
diagnostics. Like `trouble.nvim` and `lua statusline`. At first I tried
filtering out basedpyright diagnostics in these plugins. For example in
trouble.nvim I did:

```lua
config = function()
    local py_utils = require("utils.python")

    -- If we are using ruff than we want to filter out diagnostics from
    -- basedpyright (we essentially disable these on the lsp diagnostic
    -- namespace as well)
    local diag_filter = nil
    if py_utils.venv_has("ruff") then
        diag_filter = function(items)
            return vim.tbl_filter(function(item)
                return item.item.source ~= "basedpyright"
            end, items)
        end
    end

    require("trouble").setup({
        modes = {
            diagnostics = {
                filter = diag_filter,
            },
        },
    })
end,
```
this worked but then I realized that the status line plugin reported the wrong
number of diagnostics and I'd need to filter there to and figured long term
this is a losing strategy. So now I simply ignore the diagnostic signals from
the lsp directly. See below.

### Filtering basedpyright Diagnostics When Ruff Is Present

I wanted basedpyright for completions, hover, and go-to-definition, but preferred ruff for diagnostics when available. The solution is to override the `textDocument/publishDiagnostics` handler for basedpyright only:
```lua
require("lspconfig").basedpyright.setup({
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      local venv = os.getenv("VIRTUAL_ENV")
      if venv and vim.fn.executable(venv .. "/bin/ruff") == 1 then
        return  -- drop diagnostics, never reach vim.diagnostic.set()
      end
      -- no ruff in venv, use default handler
      vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
    end,
  },
})
```

This approach:
- Only affects basedpyright (other LSP clients use the global handler)
- Checks for ruff on each diagnostic publish, so it adapts if you switch venvs
- Drops diagnostics before they reach `vim.diagnostic.set()`, so `vim.diagnostic.get()` never returns them
- Keeps all other basedpyright features (completions, hover, etc.) working

### Useful Debug Commands
```vim
" List all diagnostic namespaces
:lua =vim.diagnostic.get_namespaces()

" Get all diagnostics for current buffer
:lua =vim.diagnostic.get(0)

" Check current diagnostic config
:lua =vim.diagnostic.config()
```
