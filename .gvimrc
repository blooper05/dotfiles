" Color Scheme {{{1

syntax enable
set background=dark
" let g:solarized_termcolors = 256
let g:solarized_bold = 0
let g:solarized_italic = 0
let g:solarized_underline = 0
let g:solarized_visibility = 'low'
colorscheme solarized

" gVim {{{1

set guifont=M+2VM+IPAG\ circle:h14
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
if has('multi_byte_ime') || has('xim')
  highlight CursorIM guifg=NONE guibg=LightMagenta
endif
set nobackup
set noswapfile
set clipboard+=unnamed

" Folding {{{1

set modeline
set modelines=3
set fillchars=vert:\|
" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
