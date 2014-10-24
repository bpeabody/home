set nocompatible
filetype off

" vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'a.vim'
Plugin 'camelcasemotion'
Plugin 'L9'
Plugin 'EasyMotion'
Plugin 'fugitive.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-scripts/JavaScript-Indent'
Plugin 'marijnh/tern_for_vim'

call vundle#end()            " required
filetype plugin indent on    " required

set nocp
set hidden
let mapleader = ","

" call pathogen#infect()  " install pathogen

" remap motion keys for camel case
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

let g:EasyMotion_leader_key = '<Leader>'

" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc

" use +/- directly to resize windows
map - <C-W>-
map + <C-W>+

set background=dark
colorscheme solarized

syntax on " syntax coloring

set autoindent
set expandtab     " use spaces for tab
set shiftwidth=4  " indent by this much after {, etc
set tabstop=4     " how many spaces to indent by
set smarttab
set cinoptions+=(0 " line up additional agruments to function
set textwidth=79   " line wrap at 79 chars
set ruler          " column count
set visualbell     " don't beep when error, make screen flash
set ignorecase     " perform case-insensitve searches
set smartcase      " searches are case sensitive if there is one capital letter
"set nu             " enable line numbers
set hlsearch       " highlights search matches
set incsearch      " search as you type
set history=1000   " remember more
set scrolloff=3    " keep some context when scrolling

" temporarily get rid of highlight with leader n
nmap <silent> <leader>v :silent :nohlsearch<CR>

" set working directory to that of the current file
map <leader>cd :cd %:p:h<CR>

" show whitespace
set listchars=tab:>-,trail:·
set list
nmap <silent> <leader>s :set nolist!<CR>

" scroll by 3 instead of 1
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

set wildmode=list:longest " better command mode completion

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" map ctrl-s to save
map <C-s> :wa<CR>
imap <C-s> <esc>:wa<CR>

" map to switch btwn header/cpp file
map <leader>o :A<CR>

" edit last
map <Leader>a :e #<CR>

" Pull word under cursor into LHS of a substitute
:nnoremap <Leader>z :%s/\<<C-r><C-w>\>/

" hit colon from command mode without shift!
map ; :

if exists("&colorcolumn")
    set colorcolumn=80
endif

set dictionary=/usr/share/dict/words

function! InitForText()
    set complete+=k
    set spell
endfunction

autocmd FileType markdown call InitForText()

autocmd FileType text call InitForText()
autocmd FileType txt call InitForText()

" when joining, put two spaces after '.', '?', and '!'
set joinspaces

au BufRead,BufNewFile *.bml setfiletype xml

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0        " stop pestering about file
let g:ycm_complete_in_comments = 1      " allow completion in comments
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1 " seed syntax
let g:ycm_autoclose_preview_window_after_completion = 1 " close preview window

" set up ctrlp
map <Leader>p :CtrlPBuffer<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_by_filename = 0             " match only by actual file name
let g:ctrlp_regexp = 1                  " turn on regex, off with c-r
let g:ctrlp_clear_cache_on_exit = 0     " don't delete cache
let g:ctrlp_max_files = 0               " no limit
