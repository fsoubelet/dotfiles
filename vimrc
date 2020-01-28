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

"------------------------------ Theming Vim ------------------------------

Plug 'itchyny/lightline.vim'                                                   " Minimalist status line.
Plug 'mhinz/vim-startify'                                                      " Vim startup page.
Plug 'drewtempelmeyer/palenight.vim'                                           " Colorscheme I like.
Plug 'nightsense/cosmic_latte'                                                 " Colorscheme ok for lxplus
Plug 'KeitaNakamura/neodark.vim'                                               " Colorscheme ok for lxplus
Plug 'kristijanhusak/vim-carbon-now-sh'                                        " Pretty code images
Plug 'airblade/vim-gitgutter'                                                  " Git diff in the gutter.
Plug 'tpope/vim-fugitive'                                                      " A git tools wrapper inside Vim.

"------------------------------ Vim as IDE -------------------------------

Plug 'scrooloose/nerdtree'                                                     " NERDTree.
Plug 'Xuyuanp/nerdtree-git-plugin'                                             " NERDTree git integration.
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'                                 " NERDTree syntax highlighting.
Plug 'ryanoasis/vim-devicons'                                                  " NERDTree icons.
Plug 'scrooloose/nerdcommenter'                                                " Commenting lines made easy
Plug 'christoomey/vim-tmux-navigator'                                          " Tmux integration.
Plug 'kien/ctrlp.vim'                                                          " Fuzzy file, buffer, mru, etc finder.
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }       " Testing python IDE for now

"----------------------------- Python tools ------------------------------

Plug 'davidhalter/jedi-vim'                                                    " Jedi-based completion.
Plug 'nvie/vim-flake8'                                                         " Python linting.  
Plug 'scrooloose/syntastic'                                                    " Python syntax checking.
Plug 'cjrh/vim-conda'                                                          " Conda environments integration (jedi & commands).

"---------------------------- Other Languages ----------------------------

Plug 'plasticboy/vim-markdown'                                                 " Markdown syntax.
Plug 'lervag/vimtex'                                                           " Making LaTeX easy.
Plug 'ervandew/supertab'                                                       " Make completion on <tab> command.
Plug 'tmhedberg/SimpylFold'                                                    " Colde folding.

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Making sure filetype plugin is on for plugins using it.
filetype plugin on


"##########################################################################"
"                             General Settings                             "
"##########################################################################"

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

syntax on
set autoread                                                                   " Auto read files when changed outside
let g:tex_flavor = "latex"                                                     " Auto detect LaTeX filetype

" Some hotkey re-maping
nnoremap <C-T> :%s/\s\+$//<CR> " <leader>T = Delete all trailing space in file
nnoremap <C-R> :retab<CR> " <leader>R = Converts tabs to spaces in file

" Enable accessing out-of-vim clipboard
set clipboard=unnamed

" Highlight search
if has('extra_search')
	set hlsearch                                                           " Enable search highlighting
	set incsearch                                                          " Highlight search pattern as it is being typed
endif

" Using fzf in Vim
set rtp+=/usr/local/opt/fzf

" Enabling auto syntax highlighting on madx files for lxplus
au BufNewFile,BufRead *.madx set syntax=fortran
au BufNewFile,BufRead *.seq set syntax=fortran


"##########################################################################"
"                             Plugins Settings                             "
"##########################################################################"

"------------------------------- NerdTree --------------------------------

" Open a NERDTree automatically on vim startup
"autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1

" Open a NERTree automatically on vim startup if opening target is a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Shortcut to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" Enable folder icons for vim-devicons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

"----------------------------- NERDCommenter -----------------------------

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

"-------------------------------- ctrl-p --------------------------------

" Default mapping for ctrlp plugin 
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"------------------------------- Lightline -------------------------------

set laststatus=2
set noshowmode

if !has('gui_running')
  set t_Co=256
endif

"------------------------------ Color Scheme -----------------------------

" Activate true color support mode (which iTerm supports since v3.0)
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme palenight 

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }


"##########################################################################"
"                              Python Settings                             "
"##########################################################################"

" Use UTF-8 encoding (especially important for Python3)
set encoding=utf-8

" Highlight column 100
set colorcolumn=100

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
