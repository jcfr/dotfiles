syntax enable

set pastetoggle=<F12>

" Plug manager {{{
" Vim-Plug Automatic installation {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall
end
" }}}

" vim-plug START {{{
call plug#begin('~/.vim/plugged')

Plug('sickill/vim-monokai')

call plug#end()            " required
" vim-plug END }}}

colorscheme monokai
