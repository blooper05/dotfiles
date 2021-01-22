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
vim.api.nvim_set_keymap('n', '<F5>', ':<C-u>tabnew $MYVIMRC<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F6>', ':<C-u>source $MYVIMRC<CR>', { noremap = true, silent = true })

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

-- Folding {{{1

vim.bo.modeline = true
vim.o.modelines = 3
vim.o.fillchars = [[vert:|]]
-- vim: foldmethod=marker
-- vim: foldcolumn=3
-- vim: foldlevel=0
