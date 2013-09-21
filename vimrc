set nocompatible
set nocp
set hidden
let mapleader = ","

call pathogen#infect()  " install pathogen

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

"set background=light
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
 
" File-type highlighting and configuration.
" Run :filetype (without args) to see what you may have
" to turn on yourself, or just set them all to be sure.
filetype on
filetype plugin on
filetype indent on

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

" easy escape
imap kj <Esc>

" when joining, put two spaces after '.', '?', and '!'
set joinspaces

au BufRead,BufNewFile *.bml setfiletype xml

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0

" set up ctrlp
map <Leader>p :CtrlPBuffer<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_by_filename = 0             " match only by actual file name
let g:ctrlp_regexp = 1                  " turn on regex, off with c-r
let g:ctrlp_clear_cache_on_exit = 0     " don't delete cache
let g:ctrlp_max_files = 0               " no limit

" vundle setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'ack.vim'
Bundle 'camelcasemotion'
Bundle 'ctrlp.vim'
Bundle 'EasyGrep'
Bundle 'L9'
Bundle 'The-NERD-Commenter'
Bundle 'The-NERD-tree'
Bundle 'EasyMotion'
Bundle 'fugitive.vim'
Bundle 'JavaScript-syntax'
Bundle 'surround.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/syntastic'
Bundle 'UltiSnips'
Bundle 'github-theme'
