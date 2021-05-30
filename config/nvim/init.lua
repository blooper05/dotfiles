-- Plugins {{{1

require('plugins')

-- Basic {{{1

-- Use English interface.
vim.cmd('language messages C')
vim.cmd('language time C')

-- Settings of the encoding to use for a save and reading.
vim.opt.encoding      = 'utf-8'
vim.opt.fileencodings = {
  'utf-8',
  'euc-jp',
  'sjis',
  'cp932',
  'iso-2022-jp',
}

-- Auto reload if file is changed.
vim.opt.autoread = true

-- Use system clipboard.
vim.opt.clipboard = {
  'unnamed',
  'unnamedplus',
}

-- Don't redraw during macro execution.
vim.opt.lazyredraw = true

-- Edit and reload vimrc immediately.
vim.api.nvim_set_keymap('n', '<F5>', ':<C-u>tabnew $MYVIMRC<CR>',  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F6>', ':<C-u>luafile $MYVIMRC<CR>', { noremap = true, silent = true })

-- Exit terminal mode easily.
vim.api.nvim_set_keymap('t', '<ESC>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Search {{{1

-- Ignore the case of normal letters.
vim.opt.ignorecase = true

-- If the search pattern contains upper case characters, override ignorecase option.
vim.opt.smartcase = true

-- Enable incremental search.
vim.opt.incsearch = true

-- Highlight search result.
vim.opt.hlsearch = true

-- Clear highlight.
vim.api.nvim_set_keymap('n', '<ESC><ESC>', ':<C-u>nohlsearch<CR>', { noremap = true, silent = true })

-- View {{{1

-- Show line number.
vim.opt.number = true

-- Show <TAB> and <CR>.
vim.opt.list = true

-- Don't wrap long line.
vim.opt.wrap = false

-- Always display statusline.
vim.opt.laststatus = 2

-- Show command on statusline.
vim.opt.showcmd = true

-- Show title.
vim.opt.title = true

-- Show line and column display.
vim.opt.ruler = true

-- Enable wildmode.
vim.opt.wildmenu = true
vim.opt.wildmode = {
  'list:longest',
  'full',
}

-- Splitting a window will put the new window below the current one.
vim.opt.splitbelow = true

-- Splitting a window will put the new window right the current one.
vim.opt.splitright = true

-- Create equally sized splits.
vim.opt.equalalways = true

-- Use smarter algorithms in vimdiff.
vim.opt.diffopt = {
  'internal',
  'filler',
  'closeoff',
  'iwhite',
  'vertical',
  'algorithm:histogram',
  'indent-heuristic',
}

-- Edit {{{1

-- Exchange tab to spaces.
vim.opt.expandtab = true

-- Enable backspace delete indent and newline.
vim.opt.backspace = {
  'indent',
  'eol',
  'start',
}

-- Highlight parenthesis.
vim.opt.showmatch = true

-- Ignore case on insert completion.
vim.opt.infercase = true

-- Show the effects of a command incrementally, also in a preview window.
vim.opt.inccommand = 'split'

-- Insert blank line in normal mode.
vim.api.nvim_set_keymap('n', '<CR>', 'o<ESC>', { noremap = true })

-- Command-line mode key-mappings.
vim.api.nvim_set_keymap('c', '<C-a>', '<Home>',  { noremap = true })
vim.api.nvim_set_keymap('c', '<C-e>', '<End>',   { noremap = true })
vim.api.nvim_set_keymap('c', '<C-b>', '<Left>',  { noremap = true })
vim.api.nvim_set_keymap('c', '<C-f>', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-d>', '<Del>',   { noremap = true })

-- Disable auto comments on the next line
vim.cmd('augroup AutoCommentOff')
vim.cmd('autocmd!')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=c')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=r')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=o')
vim.cmd('augroup END')

-- Syntax {{{1

-- Enable auto indent.
vim.opt.autoindent = true

-- Enable smart indent.
vim.opt.smartindent = true

-- Substitute <Tab> with blanks.
vim.opt.tabstop = 2

-- Spaces instead <Tab>.
vim.opt.softtabstop = 0

-- Auto indent width.
vim.opt.shiftwidth = 2

-- Stop syntax highlight of too long lines
vim.opt.synmaxcol = 240

-- Folding {{{1

vim.opt.modeline = true
vim.opt.modelines = 3
vim.opt.fillchars = [[vert:|]]
-- vim: foldmethod=marker
-- vim: foldcolumn=3
-- vim: foldlevel=0
