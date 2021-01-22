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

-- -- Display double-width symbols properly.
-- vim.o.ambiwidth = 'double'

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

-- Folding {{{1

vim.bo.modeline = true
vim.o.modelines = 3
vim.o.fillchars = [[vert:|]]
-- vim: foldmethod=marker
-- vim: foldcolumn=3
-- vim: foldlevel=0
