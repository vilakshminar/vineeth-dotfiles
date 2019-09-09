" Author:       Vineeth Lakshminarayanan
" Description:  This is the personal .vimrc file of Vineeth Lakshminarayanan. I've tried to
"               document every option and item.
" Email:        vinitlaks@gmail.com

" Set nocompatible makes Vim more Vim-like than Vi-like.
set nocompatible

" Check the type of file that is being edited.
filetype on
filetype plugin indent on
syntax on

" Automatically reloades .vimrc without having to restart vim.
autocmd! bufwritepost .vimrc source %

" Better copy and paste.
" Always toggle paste mode before pasting anything from clipboard.
" This ensures that the whitespaces are retained when we do a paste.
set pastetoggle=<F8>
set clipboard=unnamed

" Enable mouse and backspace in vim.
set mouse=a
set bs=2

" Rebind <Leader> key.
" Apparently EVERYONE binds <Leader> key to ','. So :)
let mapleader=","

" Quicksave command.
" Remapped ':w' to '<Ctrl>Z'
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Quickly quit current window. Remapped ':q' to '<Leader>e'
noremap <Leader>e <esc>:quit<CR>

" Quickly quit all windows. Remapped ':qa!' to '<Leader>E'. No save. Just quit.
noremap <Leader>E :qa!<CR>

" <Ctrl-X> is for replacing <ESC>
imap <C-X> <ESC>
vmap <C-X> <ESC>
nmap <C-X> <nop>

" Bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w+<movement>
" This is for splits. If you have a vertical or horizontal split.
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Easier movement between tabs.
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>
map <Leader>t <esc>:tabnew<CR>

" Map sort function to a key.
vnoremap <Leader>s :sort<CR>

" Easier movement of code blocks.
vnoremap < <gv
vnoremap > >gv

" Highlight whitespaces as a red block and <Leader>x will delete the extra
" unwanted whitespaces.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
map <Leader>x :%s/\s\+$//<CR>

" Wombat Colouring.
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat254mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
" Wombat color style looks awesome doesnt it?
set t_Co=256
color wombat256mod

" Set line number
set number

" Width of document (used by gd)
set tw=79

" Don't automatically wrap on load.
set nowrap

" Don't automatically wrap text when typing.
set fo-=t

" Useful settings.
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces. Spaces of 4 = 1 tab space.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive. When we use regex for searches.
set hlsearch
set incsearch
set ignorecase
set smartcase

" I HATE backup and swap files - They trigger too many events.
set nobackup
set nowritebackup
set noswapfile

" Please do not use the arrow keys in vim.
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

set relativenumber

" Format ugly json snippets.
nnoremap <Leader>j :%!python -m json.tool<CR>

augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END

" Remap autocomplete to Ctrl-b from <C-x><C-o>
inoremap <C-b> <C-x><C-o>
"=================================Plugins======================================

" Setup Pathogen to manage your plugins.
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder.
call pathogen#infect()

" NerdTree
" cd ~/.vim/bundle
" git clone https://github.com/scrooloose/nerdtree.git
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Ctrl-P
" cd ~/.vim
" git clone https://github.com/ctrlpvim/ctrlp.vim.git bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = 'vendor\|node_modules'

" Vim-Airline
" git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
set laststatus=2

" Allow powerline symbols to show up.
let g:airline_powerline_fonts = 1

" YCM - YouCompleteMe
" let g:ycm_key_invoke_completion = '<C-Space>'
" let g:ycm_min_num_of_chars_for_completion = 2

" ALE
" ALE has some requirements - > Vim 8.0 (compiled with python) is a must. Reinstalling vim from source might be needed. Take a look at YCM docs for that.
" Also the linters/fixers you run such as eslint, flake8, autopep8, isort have to be manually installed via pip/yarn/npm.
let g:ale_linters = { 'python': ['flake8'] , }
let g:ale_fixers = { 'python': ['autopep8', 'isort'], }
let g:ale_lint_on_text_changed = 'never'
nnoremap <Leader>f :ALEFix<CR>
"=================================Golang=======================================
function! Golang()

    " GoTags support
    " https://github.com/jstemmer/gotags
    " Run gotags -f tags -R . on your project root

    " Verbose debug statements
    " let g:go_debug = ['shell-commands']

    " Tagbar
    nnoremap <silent> <Leader>b :TagbarToggle<CR>
    let g:tagbar_width = 80

    " Vim-go
    nnoremap <silent> <Leader>c :GoCoverage<CR>
    nnoremap <silent> <Leader>v :GoCoverageClear<CR>
    nnoremap <silent> <Leader>g :GoTestFunc<CR>

    " Why am I forced to do this? I thought the vim-go plugin automatically overrides the vim defaults?
    nnoremap <silent> <C-]> :GoDef<CR>
    nnoremap <silent> <C-t> :GoDefPop<CR>
    nnoremap <silent> <Leader>r :GoReferrers<CR>

    " let g:go_def_mapping_enabled = 0
    let g:go_def_mode = 'guru'
    let g:go_fmt_command = "goimports"

endfunction

call Golang()
"=================================Python=======================================
function! Python()
    " python-editing.vim plugin - The plugin that allows you to fold python methods.
    " TODO Add support for code folding - python-editing.vim or SimpylFold.vim
    set nofoldenable

    " Partially visible vertical line for Python's max 80 character rule.
    set colorcolumn=80
    highlight ColorColumn ctermbg=233

endfunction

call Python()
