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
I use [packer.nvim](https://github.com/wbthomason/packer.nvim) to manage
my plugins. Invoking neovim will auto install packer for you but does not
download all the plugins. If doing a fresh install open neovim and wait for
packer to install. Then run `:PackerSync` to install plugins.

## Plugin System Dependencies
TODO: automate installing system dependencies.

### List of Required System Dependencies
- LSP language servers see [lsp server configurations](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- Ripgrep for [ripgrep plugin](https://github.com/BurntSushi/ripgrep#installation)
- [fd](https://github.com/sharkdp/fd#installation)
- A patched [Nerdfont](https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e)


## Plugin Troubleshooting
### PackerSync fails with Not possible to fast-forward, aborting.

This can happen when plugin owners rewrite history on a public branch. Packer
by default does a git pull with the --ff-only option. The simplest way to fix
this issue is to:

1. Comment out offending plugin
2. restart nvim
3. Run `:PackerSync` to remove the plugin
4. Uncomment Plugin
5. Restart nvim
6. Run `:PackerSync` to get the latest version

see:
 - [Packer issue #327](https://github.com/wbthomason/packer.nvim/issues/327)
 - [Packer issue #760](https://github.com/wbthomason/packer.nvim/issues/760#issuecomment-1460290691)
 
