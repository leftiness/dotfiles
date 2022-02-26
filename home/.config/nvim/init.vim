let mapleader = " "

set colorcolumn=80
set cursorline
set expandtab
set list
set listchars=tab:>-,trail:·
set number
set shiftwidth=2
set showcmd
set showtabline=2
set smarttab
set softtabstop=0
set tabstop=2

nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

inoremap jk <esc>
nnoremap <s-q> <nop>
nnoremap * :let @/='\<<c-r>=expand("<cword>")<cr>\>'<cr>:set hls<cr>

nnoremap <s-z> :q<cr>
nnoremap <s-t> :tabnew<cr>
nnoremap <s-h> gT
nnoremap <s-l> gt

nnoremap ; :
nnoremap ! :!

vnoremap <leader>y "+y
nnoremap <leader>ya :%y+<cr>
nnoremap <leader>p "+p

" Shougo/dein.vim
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('aklt/plantuml-syntax')
  call dein#add('francoiscabrol/ranger.vim')
  call dein#add('rbgrouleff/bclose.vim')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('neomake/neomake')
  call dein#add('junegunn/fzf', { 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('Omnisharp/omnisharp-vim')
  call dein#add('dense-analysis/ale')
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

" flazz/vim-colorscheme
colorscheme molokai

" francoiscabrol/ranger.vim
let g:ranger_map_keys = 0
nnoremap <leader>o :RangerWorkingDirectory<cr>

" scrooloose/nerdcommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
noremap <leader>c :call NERDComment(0, "toggle")<cr>

" neomake/neomake
let g:neomake_open_list = 2
nnoremap <leader><cr> :Neomake<cr>

" junegunn/fzf
" junegnun/fzf.vim
let g:fzf_action = { 'enter': 'tabnew' }
nnoremap <leader>f :GFiles -cmo --exclude-standard<cr>
nnoremap <leader>F :Files<cr>
nnoremap <leader>; :History:<cr>
nnoremap <leader>/ :History/<cr>
