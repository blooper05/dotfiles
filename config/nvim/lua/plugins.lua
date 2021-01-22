-- Plugin Management {{{1

local execute = vim.api.nvim_command
local fn      = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute('packadd packer.nvim')
end

vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  vim.cmd('augroup MyAutoCmd')
  vim.cmd('autocmd!')
  vim.cmd('augroup END')

  vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

  -- Appearance {{{1

  use { 'lifepillar/vim-solarized8', config = function()
    -- Assume a dark background.
    vim.o.background = 'dark'

    -- Make the background transparent.
    vim.g.solarized_termtrans = 1

    -- Use solarized as colorscheme.
    vim.cmd('autocmd MyAutoCmd VimEnter * nested colorscheme solarized8_flat')
  end }
end)

-- Folding {{{1

-- vim: foldmethod=marker
