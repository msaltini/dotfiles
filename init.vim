set nocompatible
call plug#begin()
 Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'SirVer/ultisnips'
 Plug 'preservim/nerdtree'
 Plug 'mhinz/vim-startify'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'kyazdani42/nvim-web-devicons' " for file icons
 Plug 'nvim-lualine/lualine.nvim'
 Plug 'junegunn/fzf'
 "Plug 'sheerun/vim-polyglot'
 "Plug 'ludovicchabant/vim-gutentags'
 Plug 'justinmk/vim-syntax-extra'
 "Plug 'bfrg/vim-cpp-modern'
 "Plug 'vim-python/python-syntax'
 Plug 'preservim/tagbar'
 "Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

set encoding=UTF-8
set number
set relativenumber
set showmatch
set hlsearch
set tabstop=2
set autoindent
filetype plugin on
set cursorline
"set noswapfile
set t_Co=256
"colorscheme dracula
colorscheme onehalfdark
set termguicolors

"let g:cpp_attributes_highlight = 1
"let g:cpp_member_highlight = 1
""let g:airline_theme='onehalfdark'
""let g:lightline = { 'colorscheme': 'onehalfdark' }
"let g:cpp_simple_highlight = 1
"let g:polyglot_disabled = ['sensible']

"Save and exit file
nnoremap <C-s> :wq<CR>
"Exit file without saving
nnoremap <C-q> :q!<CR>
"Toggle NERDTree using ctrl + n
nnoremap <C-n> :NERDTreeToggle<CR>  
"Toogle fuzzy file finder wit ctrl+f
nnoremap <C-f> :FZF<CR>
"Toggle tagbar with ctrl+t
nnoremap <C-t> :TagbarToggle<CR>
"Automatically close Nerdtree when it's the last window
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif 
"Setup the bar line
lua require('lualine').setup() 

set termguicolors " this variable must be enabled for colors to be applied properly

