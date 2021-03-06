" Author:       Vineeth Lakshminarayanan
" Description:  This is the personal nvim/init.vim file of Vineeth Lakshminarayanan. I've tried to
"               document every option and item.
" Email:        vinitlaks@gmail.com

" Set nocompatible makes Vim more Vim-like than Vi-like.
set nocompatible

" Check the type of file that is being edited.
filetype on
filetype plugin indent on

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
inoremap <C-X> <ESC>
vnoremap <C-X> <ESC>
nnoremap <C-X> <nop>

" Bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w+<movement>
" This is for splits. If you have a vertical or horizontal split.
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h

" Easier movement between tabs.
noremap <Leader>n <esc>:tabprevious<CR>
noremap <Leader>m <esc>:tabnext<CR>
noremap <Leader>t <esc>:tabnew<CR>

" Map sort function to a key.
vnoremap <Leader>s :sort<CR>

" Easier movement of code blocks.
vnoremap < <gv
vnoremap > >gv

" Highlight whitespaces as a red block and <Leader>x will delete the extra
" unwanted whitespaces.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
noremap <Leader>x :%s/\s\+$//<CR>

" Set line number
set number

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
"=================================Plugins======================================
call plug#begin()

" nerdtree
Plug 'scrooloose/nerdtree'

" linting
Plug 'dense-analysis/ale'

" search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" statusline
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'

" navigation
Plug 'christoomey/vim-tmux-navigator'

" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" YouCompleteMe
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !brew install cmake python
    !brew install mono nodejs
    !python3 install.py --all
  endif
endfunction
Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }

" onedark
" Copy joshdick/onedark.vim/colors/onedark.vim to ~/.config/nvim/colors/ directory
Plug 'joshdick/onedark.vim'

call plug#end()
"=============================Plugin Configuration=============================

" nerdtree
" Open nerdtree in the directory of the current file.
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction
nnoremap <silent> <C-i> :call NERDTreeToggleInCurDir()<cr>
noremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" ALE
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_set_signs = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_error = ' ✘'
let g:ale_sign_warning = ' !'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear SignColumn
nnoremap <Leader>f :ALEFix<CR>

" fzf
" start a search query by pressing \
" ripgrep needs to be installed for the following to work: https://github.com/BurntSushi/ripgrep#installation
nnoremap \ :Rg<space>
nnoremap <C-p> :FZF<cr>
let g:fzf_layout = { 'down': '40%' }

" vim-airline
" Allow powerline symbols to show up.
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
set laststatus=2

" YCM - YouCompleteMe
let g:ycm_key_invoke_completion = '<C-Space>'

" OneDark
if (has("termguicolors"))
    set termguicolors
endif
let g:onedark_termcolors=16
syntax on
colorscheme onedark
"=================================Golang=======================================
function! Golang()
    " tagbar
    " nnoremap <silent> <Leader>b :TagbarToggle<CR>
    " let g:tagbar_width = 80

    " vim-go
    nnoremap <silent> <Leader>c :GoCoverage<CR>
    nnoremap <silent> <Leader>v :GoCoverageClear<CR>
    nnoremap <silent> <Leader>g :GoTestFunc<CR>

    " Why am I forced to do this? I thought the vim-go plugin automatically overrides the vim defaults?
    nnoremap <silent> <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
    nnoremap <silent> <C-t> :GoDefPop<CR>

    let g:go_def_mode = 'gopls'
    let g:go_fmt_command = "goimports"

    let g:ale_linters = {'go': ['golangci-lint']}
    let g:ale_go_golangci_lint_options = ''

    " Verbose debug statements
    " let g:go_debug = ['shell-commands']
endfunction

call Golang()
"=================================Python=======================================
function! Python()

    " ALE configuration.
    let g:ale_linters = { 'python': ['flake8'] }
    let g:ale_fixers = { 'python': ['autopep8', 'isort'] }

    " TODO Add support for code folding - python-editing.vim or SimpylFold.vim
    set nofoldenable

    " Partially visible vertical line for Python's max 80 character rule.
    set colorcolumn=80
    highlight ColorColumn ctermbg=233

    " Width of document (used by gd)
    " set tw=79
endfunction
" call Python()
