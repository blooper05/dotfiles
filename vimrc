" NeoBundle {{{1

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', { 'build' : {
    \     'mac'  : 'make -f make_mac.mak',
    \     'unix' : 'gmake',
    \ } }
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'anyakichi/vim-surround'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/neocomplcache-rsense'
NeoBundle 'taichouchou2/rsense-0.3', { 'build' : {
    \     'unix' : 'ruby etc/config.rb > ~/.rsense',
    \ } }
NeoBundle 'tpope/vim-rails'
NeoBundle 'basyura/unite-rails'
NeoBundle 'Keithbsmiley/rspec.vim'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'mklabs/vim-backbone'
NeoBundle 'kakkyz81/evervim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'

" NeoBundle 'Yggdroot/indentLine'
" NeoBundle 'Shougo/vimfiler.vim'

filetype plugin indent on

NeoBundleCheck

" Color Scheme {{{1

syntax enable
set background=dark
" let g:solarized_termcolors = 256
let g:solarized_bold = 0
let g:solarized_italic = 0
let g:solarized_underline = 0
" let g:solarized_visibility = 'low'
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
nnoremap <silent><ESC><ESC> :<C-u>nohlsearch <CR>

" View {{{1

" Use English interface.
language message C
language time C

" Show line number.
set number
nnoremap <silent><F3> :<C-u>setlocal relativenumber!<CR>

" Show <TAB> and <CR>
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

" Enable wildmode.
set wildmenu
set wildmode=list:longest,full

" " Highlight current line.
" set cursorline
" autocmd WinEnter,BufRead * set cursorline
" autocmd WinLeave * set nocursorline

" Highlight columns longer than 80 characters.
highlight turn gui=standout cterm=standout
call matchadd("turn", '.\%>81v')

" Splitting a window will put the new window below the current one.
set splitbelow

" Splitting a window will put the new window right the current one.
set splitright

" Edit {{{1

" Setting of the encoding to use for a save and reading.
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp,utf-8,cp932,euc-jp,default,latin

" Exchange tab to spaces.
set expandtab

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Highlight parenthesis.
set showmatch

" Ignore case on insert completion.
set infercase

" Edit and reload vimrc immediately.
nnoremap <silent><F5> :<C-u>tab drop $MYVIMRC<CR>
nnoremap <silent><F6> :<C-u>source $MYVIMRC<CR>

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
inoremap <silent><CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

" switch.vim {{{2
" Plugin key-mappings.
nnoremap <silent>- :Switch<CR>

" vim-easy-align {{{2
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object
nmap <Leader>z <Plug>(EasyAlign)

" vimshell.vim {{{2
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '
" Plugin key-mappings.
nnoremap <silent><Space>s :VimShellTab<CR>

" unite.vim {{{2
" Start in insert mode.
let g:unite_enable_start_insert = 1
" Start in vsplit mode.
let g:unite_enable_split_vertically = 1
" The prefix key.
nnoremap [unite]  <Nop>
nmap     <Space>u [unite]
" Plugin key-mappings.
nnoremap <silent>[unite]f   :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent>[unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent>[unite]g   :<C-u>Unite grep<CR>
nnoremap <silent>[unite]u   :<C-u>Unite file_mru<CR>
nnoremap <silent>[unite]d   :<C-u>Unite directory_mru<CR>
nnoremap <silent>[unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent>[unite]r   :<C-u>Unite register<CR>
nnoremap <silent>[unite]k   :<C-u>Unite bookmark<CR>
nnoremap <silent>[unite]a   :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent>[unite]h   :<C-u>Unite help<CR>
nnoremap <silent>[unite]e   :<C-u>Unite ref/refe<CR>
nnoremap <silent>[unite]m   :<C-u>Unite mapping<CR>
nnoremap <silent>[unite]s   :<C-u>Unite neosnippet<CR>

call unite#custom_default_action('file', 'tabswitch')
call unite#custom#profile('action', 'context', {
      \ 'start_insert' : 1
      \ })

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

" unite-rails {{{2
" The prefix key.
nnoremap [rails]  <Nop>
nmap     <Space>r [rails]
" Plugin key-mappings.
nnoremap <silent>[rails]m   :<C-u>Unite rails/model<CR>
nnoremap <silent>[rails]v   :<C-u>Unite rails/view<CR>
nnoremap <silent>[rails]c   :<C-u>Unite rails/controller<CR>
nnoremap <silent>[rails]s   :<C-u>Unite rails/spec<CR>
nnoremap <silent>[rails]g   :<C-u>Unite rails/config<CR>
nnoremap <silent>[rails]l   :<C-u>Unite rails/log<CR>

" syntastic {{{2
" Use the :sign interface to note errors.
let g:syntastic_enable_signs = 1
" Automatically open and close the location list.
let g:syntastic_auto_loc_list = 2
let g:syntastic_ruby_checkers = ['rubocop']

" vim-fugitive {{{2
" The prefix key.
nnoremap [git]    <Nop>
nmap     <Space>g [git]
" Plugin key-mappings.
nnoremap <silent>[git]s :<C-u>Gstatus<CR>
nnoremap <silent>[git]d :<C-u>Gdiff<CR>
nnoremap <silent>[git]a :<C-u>Gwrite<CR>
nnoremap <silent>[git]c :<C-u>Gcommit<CR>
nnoremap <silent>[git]r :<C-u>Gread<CR>
nnoremap <silent>[git]b :<C-u>Gblame<CR>

" gitv {{{2
nnoremap <silent>[git]l :<C-u>Gitv<CR>
nnoremap <silent>[git]f :<C-u>Gitv!<CR>

" vim-ref {{{2
" Set the reference path.
let g:ref_refe_cmd = expand('~/.vim/ref/rubyrefm/refe-1_9_3')

" neocomplcache-rsense {{{2
" Set $RSENSE_HOME path.
let g:neocomplcache#sources#rsense#home_directory = expand('~/.vim/bundle/rsense-0.3')

" vim-rspec {{{2
" Plugin key-mappings.
nnoremap <silent><Leader>c :call RunCurrentSpecFile()<CR>
nnoremap <silent><Leader>n :call RunNearestSpec()<CR>
nnoremap <silent><Leader>l :call RunLastSpec()<CR>
nnoremap <silent><Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = '!bundle exec rspec -fd -c {spec}'

" simple-javascript-indenter {{{2
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" lightline.vim {{{2
let g:lightline = {
    \ 'colorscheme' : 'solarized',
    \ 'mode_map'    : { 'c' : 'NORMAL' },
    \ 'active'      : {
    \   'left'      : [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function' : {
    \   'modified'     : 'MyModified',
    \   'readonly'     : 'MyReadonly',
    \   'fugitive'     : 'MyFugitive',
    \   'filename'     : 'MyFilename',
    \   'fileformat'   : 'MyFileformat',
    \   'filetype'     : 'MyFiletype',
    \   'fileencoding' : 'MyFileencoding',
    \   'mode'         : 'MyMode',
    \ },
    \ 'separator'    : { 'left' : '⮀', 'right' : '⮂' },
    \ 'subseparator' : { 'left' : '⮁', 'right' : '⮃' }
    \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
      \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
      \  &ft == 'unite' ? unite#get_status_string() :
      \  &ft == 'vimshell' ? vimshell#get_status_string() :
      \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
      \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" Folding {{{1

set modeline
set modelines=3
set fillchars=vert:\|
" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
