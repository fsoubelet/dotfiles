"##########################################################################"
"                             Vim-Plug SECTION                             "
"##########################################################################"

"Auto-install vim-plug if it's not already here
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Plugins for programming
Plug 'davidhalter/jedi-vim'                     " Jedi-based completion.
Plug 'ervandew/supertab'                        " Make completion on <tab> command.
Plug 'tmhedberg/SimpylFold'                     " Colde folding.
Plug 'vim-scripts/indentpython.vim'             " Proper Python indentation.
Plug 'nvie/vim-flake8'                          " PEP8 checking.  
Plug 'python/black'                             " Python formatting.
Plug 'scrooloose/syntastic'                     " Syntax checking.
Plug 'cjrh/vim-conda'                           " Conda environments integration (jedi & commands).
Plug 'plasticboy/vim-markdown'                  " Markdown syntax.
Plug 'lervag/vimtex'                            " Making LaTeX easy.
Plug 'scrooloose/nerdcommenter'                 " Commenting lines made easy

" UX & UI plugins
Plug 'scrooloose/nerdtree'                      " NERDTree.
Plug 'ryanoasis/vim-devicons'                   " NERDTree icons.
Plug 'Xuyuanp/nerdtree-git-plugin'              " NERDTree git integration.
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " NERDTree syntax highlighting.
Plug 'christoomey/vim-tmux-navigator'           " Tmux integration.
Plug 'kien/ctrlp.vim'                           " Fuzzy file, buffer, mru, etc finder.
Plug 'airblade/vim-gitgutter'                   " Git diff in the gutter.
Plug 'itchyny/lightline.vim'                    " Minimalist status line.
Plug 'drewtempelmeyer/palenight.vim'            " Colorscheme I like.
Plug 'mhinz/vim-startify'                       " Vim startup page.
Plug 'kristijanhusak/vim-carbon-now-sh'         " Pretty code images

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Making sure filetype plugin is on for plugins using it.
filetype plugin on

" Setting the Leader key
let mapleader = ','

" Split panes control: Ctrl and natural vim keymap navigation (hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding (use za or the space bar in normal mode for (un)folding.
set foldmethod=indent
set foldlevel=99
nnoremap <space> za


"####################"
"     1. General     "
"####################"
syntax on
set autoread   " Auto read files when changed outside
let g:tex_flavor = "latex" " Auto detect latex filetype


"####################"
"     2. Hotkeys     "
"####################"
nnoremap <C-T> :%s/\s\+$//<CR> " <leader>T = Delete all trailing space in file
nnoremap <C-R> :retab<CR> " <leader>R = Converts tabs to spaces in file


"##########################################################################"
"                             NERDTree SECTION                             "
"##########################################################################"

" Open a NERDTree automatically on vim startup (including when opening a
" directory)
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Shortcut to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>


"##########################################################################"
"                          NERDCommenter SECTION                           "
"##########################################################################"

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0 

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1


"##########################################################################"
"                              Python SECTION                              "
"##########################################################################"

" Use UTF-8 encoding (especially important for Python3)
set encoding=utf-8

" Enable python syntax highlighting
let python_highlight_all = 1

" Turn on line numbering
set number

" Make sure I have proper PEP8 indentation
au BufNewFile,BufRead *.py:
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set showmatch
    \ set autoindent
    \ set fileformat=unix

" Ignore .pyc files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Set line length for Black formatting
let g:black_linelength = 100


"##########################################################################"
"                              Miscellaneous                               "
"##########################################################################"

" Auto syntax for madx files
au BufReadPost,BufNewFile *.madx,*.mad,*.seq setf madx

" Enable accessing out-of-vim clipboard
set clipboard=unnamed

" Enable folder icons for vim-devicons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" Default mapping for ctrlp plugin 
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Configuring lightline
set laststatus=2
set noshowmode

if !has('gui_running')
  set t_Co=256
endif

" Set colorscheme
" Activate true color support mode (which iTerm supports since v3.0)
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme palenight 

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
