#!/bin/bash
#vim setup
cd /root
touch .vimrc
echo "let g:netrw_banner = 0" > .vimrc
echo "let g:netrw_liststyle = 3" >> .vimrc
echo "let g:netrw_browse_split = 4" >> .vimrc
echo "let g:netrw_altv = 1" >> .vimrc
echo "let g:netrw_winsize = 25" >> .vimrc
echo "augroup ProjectDrawer" >> .vimrc
echo "  autocmd!" >> .vimrc
echo "  autocmd VimEnter * :Vexplore" >> .vimrc
echo "augroup END" >> .vimrc
echo "syntax on" >> .vimrc
echo "colorscheme industry" >> .vimrc
cat .vimrc
