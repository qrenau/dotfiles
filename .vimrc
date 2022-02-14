set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
"
"" Ma liste de plugins"
Plugin 'scrooloose/nerdtree' " Nerdtree plugin
Plugin 'itchyny/lightline.vim' " Light line
Plugin 'maximbaz/lightline-ale'
Plugin 'ervandew/supertab'
Plugin 'sirver/ultisnips'
Plugin 'a.vim'
Plugin 'raimondi/delimitmate'
Plugin 'rafalbromirski/vim-aurora'
"Plugin 'scrooloose/syntastic'
Plugin 'w0rp/ale'
Plugin 'scrooloose/nerdcommenter'
Plugin 'olical/vim-expand'

call vundle#end()
filetype plugin indent on
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
"" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<F1>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
"" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_fixers = {
\   'python': ['autopep8','yapf','remove_trailing_lines', 'trim_whitespace']}

let g:lightline = {}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]] }
let g:lightline.active = {
            \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
            \            [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'fileformat', 'fileencoding', 'filetype'] ] }

let g:ale_python_flake8_options = '--ignore=E201,E202,E203,E211,E223,E224,E225,E231,E251,E30,E501,E226,E261,E265,E262,E741,E711,W291,E241'

set number
syntax on
colorscheme aurora
set laststatus=2
filetype indent on  " activates indenting for files
set softtabstop=4   " width of a tab
set tabstop=4
set shiftwidth=4    " width of the indentation
set expandtab
set ai			        " Activer l'indentation automatique
set si			        " Activer l'indentation intelligente
set showcmd		        " Affiche (partiellement) la commande dans la barre de statut
set showmatch		        " Afficher les brackets qui correspondent
set ignorecase		        " Recherche insensible à la casse
set incsearch		        " Recherche insensible à la casseet shiftwidth=4
set ruler
set nu              " show line numbers
set virtualedit=block
set mouse=a
set clipboard=unnamed
set listchars=trail:+,nbsp:+,tab:˲\ ,extends:»,precedes:«, " print tabs with a special character (add ",eol:·" for end of lines)
set list
set hlsearch        " highlight what you search for

" move the current line up or down with the Ctrl-arrow keys
nmap <C-Down> :<C-u>move .+1<CR>
nmap <C-Up>   :<C-u>move .-2<CR>
imap <C-Down> <C-o>:<C-u>move .+1<CR>
imap <C-Up>   <C-o>:<C-u>move .-2<CR>
vmap <C-Down> :move '>+1<CR>gv
vmap <C-Up> :move '<-2<CR>gv

" When jumping to a given line, center the screen
nnoremap G Gzz

:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel " surround the word in double quotes

let mapleader = ","
" ,s will split vertically and swith over the new panel
nnoremap <leader>s <C-w>v<C-w>l:bn<CR>

" ,S will split horizontally and swith over the new panel
nnoremap <leader>S <C-w>s<C-w>l:bn<CR>

iabbrev adn and
