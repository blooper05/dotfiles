-- Basic {{{1

-- Use English interface.
vim.cmd('language messages C')
vim.cmd('language time C')

-- Settings of the encoding to use for a save and reading.
vim.opt.encoding = 'utf-8'
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
vim.keymap.set('n', '<F5>', function()
  vim.cmd('tabedit $MYVIMRC')
end, { silent = true })

vim.keymap.set('n', '<F6>', function()
  vim.cmd('luafile $MYVIMRC')
end, { silent = true })

-- Exit terminal mode easily.
vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]], { silent = true })

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
vim.keymap.set('n', '<ESC><ESC>', function()
  vim.cmd('nohlsearch')
end, { silent = true })

-- View {{{1

-- Show line number.
vim.opt.number = true

-- Show <TAB> and <CR>.
vim.opt.list = true

-- Don't wrap long line.
vim.opt.wrap = false

-- Always and only the last window display statusline.
vim.opt.laststatus = 3

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

-- Keep the text on the same screen line.
vim.opt.splitkeep = 'screen'

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
vim.keymap.set('n', '<CR>', 'o<ESC>', {})

-- Command-line mode key-mappings.
vim.keymap.set('c', '<C-a>', '<Home>', {})
vim.keymap.set('c', '<C-e>', '<End>', {})
vim.keymap.set('c', '<C-b>', '<Left>', {})
vim.keymap.set('c', '<C-f>', '<Right>', {})
vim.keymap.set('c', '<C-d>', '<Del>', {})

-- Disable auto comments on the next line
local noAutoComment = vim.api.nvim_create_augroup('NoAutoComment', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = noAutoComment,
  callback = function()
    vim.cmd('setlocal formatoptions-=c')
    vim.cmd('setlocal formatoptions-=r')
    vim.cmd('setlocal formatoptions-=o')
  end,
})

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

-- Packages {{{1

require('packages')

-- Folding {{{1

vim.opt.modeline = true
vim.opt.modelines = 3
vim.opt.fillchars = [[vert:|]]
-- vim: foldmethod=marker
-- vim: foldcolumn=3
-- vim: foldlevel=0
