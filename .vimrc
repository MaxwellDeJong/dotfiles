if has('termguicolors')
  set termguicolors
endif

if hostname() == "max-desktop"
  colorscheme wombat256-local
elseif hostname() == "compute-node-1"
  colorscheme wombat256-server
else
  colorscheme wombat256
endif

:set t_Co=256

set smartindent
set tabstop=2
set shiftwidth=2
set relativenumber
"set softtabstop=2
set expandtab

set number
set showcmd

filetype indent on
" Settings for Latex-Suite
filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,bib,pdf'

let mapleader = '\'
let leader = '\'

autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType python set colorcolumn=78
autocmd FileType cython set colorcolumn=78

"autocmd Filetype tex set spell spelllang=en_us

set showmatch
set incsearch
set hlsearch

nnoremap j gj
nnoremap k gk
nnoremap 0 ^
