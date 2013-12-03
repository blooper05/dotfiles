" NeoBundle {{{1

set nocompatible

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', { 'build' : {
    \     'unix' : 'make -f make_unix.mak',
    \ } }
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'anyakichi/vim-surround'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/neocomplcache-rsense'
NeoBundle 'taichouchou2/rsense-0.3', { 'build' : {
    \     'unix' : 'ruby etc/config.rb > ~/.rsense',
    \ } }
NeoBundle 'tpope/vim-rails'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'tpope/vim-haml'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'

" NeoBundle 'Yggdroot/indentLine'
" Neobundle 'Shougo/vimfiler.vim'
" Neobundle 'Shougo/vimshell.vim'

filetype plugin indent on

NeoBundleCheck

" Color Scheme {{{1

syntax enable
set background=dark
let g:solarized_termcolors = 256
let g:solarized_bold = 0
let g:solarized_italic = 0
let g:solarized_underline = 0
let g:solarized_visibility = 'low'
colorscheme solarized

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
nnoremap <ESC><ESC> :nohlsearch <CR>

" View {{{1

" Use English interface.
language message C
language time C
" Show line number.
set number
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>
" Show <TAB> and <CR>
" set list
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
" Enable wildmode.
set wildmenu
set wildmode=list:longest,full
" Highlight current line.
set cursorline
" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right the current one.
set splitright

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

" Auto Command {{{1

" Automatically removing trailing spaces.
autocmd BufWritePre * :%s/\s\+$//ge
" Automatically replacing <Tab> by spaces.
autocmd BufWritePre * :%s/\t/  /ge

" Plugin {{{1

" neocomplcache {{{2
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 0
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2

" neosnippet {{{2
" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"
" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" vim-endwise {{{2
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

" unite.vim {{{2
" Start in insert mode.
let g:unite_enable_start_insert = 1
" Start in vsplit mode.
let g:unite_enable_split_vertically = 1
" The prefix key.
nnoremap [unite]    <Nop>
nmap     <Space>u [unite]
" Plugin key-mappings.
nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r   :<C-u>Unite register<CR>
nnoremap <silent> [unite]o   :<C-u>Unite outline<CR>
nnoremap <silent> [unite]u   :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]d   :<C-u>Unite directory_mru<CR>
nnoremap <silent> [unite]k   :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]s   :<C-u>Unite source<CR>
nnoremap <silent> [unite]f   :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]g   :<C-u>Unite grep<CR>
nnoremap <silent> [unite]h   :<C-u>Unite help<CR>
nnoremap <silent> [unite];   :<C-u>Unite history/command<CR>
nnoremap <silent> [unite]/   :<C-u>Unite history/search<CR>
nnoremap <silent> [unite]y   :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]a   :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]n   :<C-u>Unite neobundle/install:!<CR>
nnoremap <silent> [unite]e   :<C-u>Unite snippet<CR>
nnoremap <silent> [unite]q   :<C-u>Unite quickfix<CR>
" nnoremap <silent> [unite]p   :<C-u>Unite ref/perldoc<CR>
nnoremap <silent> [unite]p   :<C-u>Unite ref/refe<CR>
nnoremap <silent> [unite]m   :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]l   :<C-u>Unite colorscheme -auto-preview<CR>

" syntastic {{{2
" Use the :sign interface to note errors.
let g:syntastic_enable_signs = 1
" Automatically opne and close the location list.
let g:syntastic_auto_loc_list = 2

" vim-fugitive {{{2
" The prefix key.
nnoremap [git]    <Nop>
nmap     <Space>g [git]
" Plugin key-mappings.
nnoremap <silent> [git]s :<C-u>Gstatus<CR>
nnoremap <silent> [git]d :<C-u>Gdiff<CR>
nnoremap <silent> [git]l :<C-u>Glog<CR>
nnoremap <silent> [git]a :<C-u>Gwrite<CR>
nnoremap <silent> [git]c :<C-u>Gcommit<CR>
nnoremap <silent> [git]r :<C-u>Gread<CR>

" vim-ref {{{2
" Set the reference path.
let g:ref_refe_cmd = expand('~/.vim/ref/rubyrefm/refe-1_9_3')

" neocomplcache-rsense {{{2
" Set $RSENSE_HOME path.
let g:neocomplcache#sources#rsense#home_directory = expand('~/.vim/bundle/rsense-0.3')

" vim-rspec {{{2
" Plugin key-mappings.
nnoremap <silent> <Leader>c :call RunCurrentSpecFile()<CR>
nnoremap <silent> <Leader>n :call RunNearestSpec()<CR>
nnoremap <silent> <Leader>l :call RunLastSpec()<CR>
nnoremap <silent> <Leader>a :call RunAllSpecs()<CR>

" Folding {{{1

set modeline
set modelines=3
set fillchars=vert:\|
" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
