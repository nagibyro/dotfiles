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
