set nocompatible
set nocp
set hidden
let mapleader = " "

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"" let Vundle manage Vundle
"" required! 
"Bundle 'gmarik/vundle'
"
"" My Bundles here:
""
"" original repos on github
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
"" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
"Bundle "pangloss/vim-javascript"

let g:EasyMotion_leader_key = '<Leader>'

" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc

" use +/- directly to resize windows
map - <C-W>-
map + <C-W>+

colorscheme elflord

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
nmap <silent> <leader>n :silent :nohlsearch<CR>

" set working directory to that of the current file
map <leader>cd :cd %:p:h<CR>

" show whitespace
set listchars=tab:>-,trail:�
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

function! l:buildAndMakeTags()
  wa
  " silent !ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .
  make
endfunction

function! l:buildAndRun()
    call l:buildAndMakeTags()
    !sh ./run.sh
endfunction

" map f5 to make
map <F5> ::call l:buildAndRun()<CR>
imap <F5> <esc>:call l:buildAndRun()<CR>

" map f7 to make
map <F7> ::call l:buildAndMakeTags()<CR>
imap <F7> <esc>:call l:buildAndMakeTags()<CR>

" map ctrl-s to save
map <C-s> :wa<CR>
imap <C-s> <esc>:wa<CR>

" map to switch btwn header/cpp file
map <C-k> :A<CR>
imap <C-k> <esc>:A<CR>i

" edit last
map <Leader>a :e #<CR>

" Pull word under cursor into LHS of a substitute
:nnoremap <Leader>z :%s/\<<C-r><C-w>\>/

" hit colon from command mode without shift!
map ; :

" tex stuff
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

if exists("&colorcolumn")
    set colorcolumn=80
endif

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

function! InitForTex()
    iab ttt \texttt{
endfunction

autocmd FileType tex call InitForTex()

function! InitForXml()
    set tabstop=2
    set shiftwidth=2
endfunction

autocmd FileType xml call InitForXml()

" easy escape
imap kj <Esc>

" when joining, put two spaces after '.', '?', and '!'
set joinspaces
