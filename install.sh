cd ~/
if [ -f .bashrc ]
then
  cp .bashrc bashrc.orginal
fi

if [ -f .vimrc ]
then
  cp ~/.vimrc ~/vimrc.orginal
fi

ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/vimrc ~/.vimrc
