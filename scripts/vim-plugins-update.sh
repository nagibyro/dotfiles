#/usr/bin/env bash

#main script here...
function run_script() {
	cur_dir="$( cd "$( dirname "$0" )" && pwd )"

	#git subtree pull --prefix vim/bundle/nerdtree https://github.com/preservim/nerdtree.git 6.10.16 --squash
	#git subtree pull --prefix vim/bundle/vim-fugitive https://github.com/tpope/vim-fugitive.git master --squash
	git subtree pull --prefix vim/bundle/vim-surround https://github.com/tpope/vim-surround.git master --squash
	git subtree pull --prefix vim/bundle/vim-airline https://github.com/vim-airline/vim-airline.git 0.11 --squash
	git subtree pull --prefix vim/bundle/syntastic https://github.com/vim-syntastic/syntastic.git 3.10.0 --squash
	
}

run_script "$@"
exit 0
