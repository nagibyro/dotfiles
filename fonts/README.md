# Berkeley Mono
I really like the [Berkeley Mono Typeface](https://berkeleygraphics.com/typefaces/berkeley-mono/)
this readme is a brain dump on how download, patch (to add nerdfont icons ect...), and install
Berekley Mono.

## Steps

1. Login to [https://berkeleygraphics.com/typefaces/berkeley-mono/](https://berkeleygraphics.com/typefaces/berkeley-mono/)
and download a copy of font. (use .otf)
2. create an input dir and output dir for the fonts
    - recommended `mkdir -p ~/opt/berkeley-mono/original && mkdir -p
      ~/opt/berkeley-mono/patched`
3. Run [Nerd Font Patcher Script](https://github.com/ryanoasis/nerd-fonts/wiki/ScriptOptions)
    - Use the script in dotfiles `gen-berkley-mono-otf-fonts.sh` which uses docker

### Notes on step 3
- The berkeley-mono fonts seem to have some managled font metadata so when the
  nerd font pather script runs it was putting each input file to the same name
  output file so they were all clobbering each other. The `gen-berkley-mono-otf-fonts.sh`
  script works around this issue and gets you each file out with an appropriate
  name

- If running on fedora with podman (also maybe with docker) if SELinux is enabled
  you might get permissions error on the mounted volumes. You need to add flags
  to the mount option
    - `-v ~/opt/berkeley-mono/original:/in` needs to be `-v ~/opt/berkeley-mono/original:/in:z`

  same for the `/out` volume.

4. Install Patched fonts based on OS
    - **MacOS** copy patched fonts into `~/Library/Fonts`
    - **Fedora**
        - `mkdir -p ~/.local/share/fonts/berkeley-mono-nf`
        - `cp ~/opt/berkeley-mono/patched/*.ttf ~/.local/share/fonts/berkeley-mono-nf`
        - `fc-cache -v`
