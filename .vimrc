" Author:	Vineeth Lakshminarayanan
" Description:	This is the personal .vimrc file of Vineeth Lakshminarayanan. I've tried to
" 		document every option and item.
" Email:	vinitlaks@gmail.com

" set nocompatible makes Vim more Vim-like than Vi-like
set nocompatible

" What does this do????
filetype off
filetype plugin indent on
syntax on

" Automatically reloades .vimrc without having to restart vim
autocmd! bufwritepost .vimrc source %

" Better copy and paste
set pastetoggle=<F2>
set clipboard=unnamed

" Enable mouse and backspace in vim
set mouse=a	" enable mouse in vim.
set bs=2

" Rebind <Leader> key
" Apparently, EVERYONE binds <Leader> key to ','. So :)
let mapleader=","

" Quicksave command
" Remapped '<ESC>:w' to '<Ctrl>Z'
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Quickly quit current window. Remapped ':q' to '<Leader>e'.
noremap <Leader>e <esc>:quit<CR>

" Quickly quit all windows. Remapped ':qa!' to '<Leader>E'.
noremap <Leader>E :qa!<CR>

" <Ctrl-X> is for replacing <ESC>
:imap <C-X> <ESC>

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w+<movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier movement between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>
map <Leader>t <esc>:tabnew<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier movement of code blocks
vnoremap < <gv
vnoremap > >gv

" Highlight whitespaces as a red block and <Leader>x will delete the extra unwanted whitespaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
map <Leader>x :%s/\s\+$//<CR>

" Wombat Colouring
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat255mod.vim " http://www.vim.org/scripts/download_script.php?src_id=13400
" Wombat color style looks awesome doesnt it?
set t_Co=256
color wombat256mod

" Line numbers, 80 chars per line max and other fonts
set number
set tw=79
set nowrap
set fo-=t
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Pressing Q in the middle of a paragraph will align it to < 80 chars
vmap Q gq
nmap Q gqap

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" I HATE backup and swap files.
set nobackup
set nowritebackup
set noswapfile

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim
" https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" =============================================================================
" Python IDE Setup
" =============================================================================

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim
" https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
set laststatus=2

" NerdTree
" cd ~/.vim/bundle
" git clone https://github.com/scrooloose/nerdtree.git
map <F2> :NERDTreeToggle<CR>

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim
" http://www.vim.org/scripts/download_script.php?src_id=5491
set foldmethod=indent   "fold based on indent
set foldnestmax=9      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=-0         "this is just what i use

" Flake8
" cd ~/.vim/bundle
" git clone https://github.com/nvie/vim-flake8.git
autocmd FileType python map <buffer> <F3> :call Flake8()<CR>

" =============================================================================
" Java IDE Setup
" =============================================================================

" cd ~/.vim/bundle
" git clone https://github.com/artur-shaik/vim-javacomplete2.git
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Smart (trying to guess import option) inserting class imports with F4
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

" Usual (will ask for import option) inserting class imports with F5
nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)

" To add all missing imports with F6
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)

" To remove all missing imports with F7
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
