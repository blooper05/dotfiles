" Dein.vim {{{1

augroup MyAutoCmd
  autocmd!
augroup END

let s:cache_home    = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir      = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

let &runtimepath = s:dein_repo_dir . ',' . &runtimepath

let s:toml_file = fnamemodify(expand('<sfile>'), ':h') . '/dein.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

syntax enable

filetype plugin indent on

" Basic {{{1

" Use English interface.
language messages C
language time C

" Settings of the encoding to use for a save and reading.
set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp

" Auto reload if file is changed.
set autoread

" Use system clipboard.
set clipboard+=unnamed

" Don't redraw during macro execution.
set lazyredraw

" Edit and reload vimrc immediately.
nnoremap <silent><F5> :<C-u>tabnew $MYVIMRC<CR>
nnoremap <silent><F6> :<C-u>source $MYVIMRC<CR>

" Exit terminal mode easily.
tnoremap <silent><ESC> <C-\><C-n>

" Search {{{1

" Ignore the case of normal letters.
set ignorecase

" If the search pattern contains upper case characters, override ignorecase option.
set smartcase

" Enable incremental search.
set incsearch

" Highlight search result.
set hlsearch

" Clear highlight.
nnoremap <silent><ESC><ESC> :<C-u>nohlsearch<CR>

" View {{{1

" Show line number.
set number

" Show <TAB> and <CR>.
set list

" Don't wrap long line.
set nowrap

" Always display statusline.
set laststatus=2

" Show command on statusline.
set showcmd

" Show title.
set title

" Show line and column display.
set ruler

" " Display double-width symbols properly.
" set ambiwidth=double

" Enable wildmode.
set wildmenu
set wildmode=list:longest,full

" Splitting a window will put the new window below the current one.
set splitbelow

" Splitting a window will put the new window right the current one.
set splitright

" Create equally sized splits.
set equalalways

" Use smarter algorithms in vimdiff.
set diffopt+=iwhite
set diffopt+=vertical
set diffopt+=algorithm:histogram
set diffopt+=indent-heuristic

" Edit {{{1

" Exchange tab to spaces.
set expandtab

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Highlight parenthesis.
set showmatch

" Ignore case on insert completion.
set infercase

" Insert blank line in normal mode.
nnoremap <CR> o<ESC>

" Command-line mode key-mappings.
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>

" Syntax {{{1

" Enable auto indent.
set autoindent

" Enable smart indent.
set smartindent

" Substitute <Tab> with blanks.
set tabstop=2

" Spaces instead <Tab>.
set softtabstop=0

" Auto indent width.
set shiftwidth=2

" Stop syntax highlight of too long lines
set synmaxcol=160

" Auto Command {{{1

function! s:rstrip()
  let s:cursor = getpos('.')
  if &filetype == 'markdown'
    %s/\v(\s{2})?(\s+)?$/\1/e
    match Underlined /\v\s{2}$/
  else
    %s/\v\s+$//e
  endif
  call setpos('.', s:cursor)
endfunction

augroup AutoRemoveTrailingSpaces
  autocmd!
  autocmd BufWritePre * call s:rstrip()
augroup END

augroup AutoReplaceTabBySpaces
  autocmd!
  autocmd BufWritePre * :%s/\t/  /ge
augroup END

augroup AutoCommentOff
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" Folding {{{1

set modeline
set modelines=3
set fillchars=vert:\|
" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
