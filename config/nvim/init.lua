-- Plugins {{{1

require('plugins')

-- Basic {{{1

-- Use English interface.
vim.cmd('language messages C')
vim.cmd('language time C')

-- Settings of the encoding to use for a save and reading.
vim.o.encoding      = 'utf-8'
vim.o.fileencodings = 'utf-8,euc-jp,sjis,cp932,iso-2022-jp'

-- Auto reload if file is changed.
vim.bo.autoread = true

-- Use system clipboard.
vim.o.clipboard = table.concat({
  'unnamed',
  'unnamedplus',
  vim.o.clipboard,
}, ',')

-- Don't redraw during macro execution.
vim.o.lazyredraw = true

-- Edit and reload vimrc immediately.
vim.api.nvim_set_keymap('n', '<F5>', ':<C-u>tabnew $MYVIMRC<CR>',  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F6>', ':<C-u>luafile $MYVIMRC<CR>', { noremap = true, silent = true })

-- Exit terminal mode easily.
vim.api.nvim_set_keymap('t', '<ESC>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Search {{{1

-- Ignore the case of normal letters.
vim.o.ignorecase = true

-- If the search pattern contains upper case characters, override ignorecase option.
vim.o.smartcase = true

-- Enable incremental search.
vim.o.incsearch = true

-- Highlight search result.
vim.o.hlsearch = true

-- Clear highlight.
vim.api.nvim_set_keymap('n', '<ESC><ESC>', ':<C-u>nohlsearch<CR>', { noremap = true, silent = true })

-- View {{{1

-- Show line number.
vim.wo.number = true

-- Show <TAB> and <CR>.
vim.wo.list = true

-- Don't wrap long line.
vim.wo.wrap = false

-- Always display statusline.
vim.o.laststatus = 2

-- Show command on statusline.
vim.o.showcmd = true

-- Show title.
vim.o.title = true

-- Show line and column display.
vim.o.ruler = true

-- Enable wildmode.
vim.o.wildmenu = true
vim.o.wildmode = table.concat({
  vim.o.wildmode,
  'list:longest',
  'full',
}, ',')

-- Splitting a window will put the new window below the current one.
vim.o.splitbelow = true

-- Splitting a window will put the new window right the current one.
vim.o.splitright = true

-- Create equally sized splits.
vim.o.equalalways = true

-- Use smarter algorithms in vimdiff.
vim.o.diffopt = table.concat({
  vim.o.diffopt,
  'iwhite',
  'vertical',
  'algorithm:histogram',
  'indent-heuristic',
}, ',')

-- Edit {{{1

-- Exchange tab to spaces.
vim.bo.expandtab = true

-- Enable backspace delete indent and newline.
vim.o.backspace = table.concat({
  'indent',
  'eol',
  'start',
}, ',')

-- Highlight parenthesis.
vim.o.showmatch = true

-- Ignore case on insert completion.
vim.bo.infercase = true

-- Show the effects of a command incrementally, also in a preview window.
vim.o.inccommand = 'split'

-- Insert blank line in normal mode.
vim.api.nvim_set_keymap('n', '<CR>', 'o<ESC>', { noremap = true })

-- Command-line mode key-mappings.
vim.api.nvim_set_keymap('c', '<C-a>', '<Home>',  { noremap = true })
vim.api.nvim_set_keymap('c', '<C-e>', '<End>',   { noremap = true })
vim.api.nvim_set_keymap('c', '<C-b>', '<Left>',  { noremap = true })
vim.api.nvim_set_keymap('c', '<C-f>', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-d>', '<Del>',   { noremap = true })

-- Disable auto comments on the next line
vim.cmd('autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o')

-- Syntax {{{1

-- Enable auto indent.
vim.bo.autoindent = true

-- Enable smart indent.
vim.bo.smartindent = true

-- Substitute <Tab> with blanks.
vim.bo.tabstop = 2

-- Spaces instead <Tab>.
vim.bo.softtabstop = 0

-- Auto indent width.
vim.bo.shiftwidth = 2

-- Stop syntax highlight of too long lines
vim.bo.synmaxcol = 240

-- Folding {{{1

vim.bo.modeline = true
vim.o.modelines = 3
vim.o.fillchars = [[vert:|]]
-- vim: foldmethod=marker
-- vim: foldcolumn=3
-- vim: foldlevel=0
