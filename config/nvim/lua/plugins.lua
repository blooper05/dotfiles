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

  use { 'glepnir/indent-guides.nvim', config = function()
    -- Enable 24-bit RGB color in the TUI.
    vim.o.termguicolors = true

    require('indent_guides').setup({})
  end,
  }

  use { 'hoob3rt/lualine.nvim', config = function()
    local lualine = require('lualine')
    lualine.theme = 'forest_night'
    lualine.status()
  end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  use { 'nvim-treesitter/nvim-treesitter', config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed      = 'all',
      highlight             = { enable = true },
      incremental_selection = { enable = true },
      indent                = { enable = true },
    })
  end }
end)

-- Folding {{{1

-- vim: foldmethod=marker
