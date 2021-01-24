-- Plugin Management {{{1

local execute = vim.api.nvim_command
local fn      = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute('packadd packer.nvim')
end

vim.cmd('packadd packer.nvim')

vim.cmd('augroup MyAutoCmd')
vim.cmd('autocmd!')
vim.cmd('augroup END')

return require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true, config = function()
    -- Run :PackerCompile whenever plugins.lua is updated automatically.
    vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')
  end,
  }

  -- Appearance {{{1

  use { 'lifepillar/vim-solarized8', config = function()
    -- Assume a dark background.
    vim.o.background = 'dark'

    -- Make the background transparent.
    vim.g.solarized_termtrans = 1

    -- Use solarized as colorscheme.
    vim.cmd('autocmd MyAutoCmd VimEnter * nested colorscheme solarized8_flat')
  end,
  }

  use { 'hoob3rt/lualine.nvim', config = function()
    -- Get rid of redundant mode display.
    vim.o.showmode = false

    local lualine = require('lualine')
    lualine.theme = 'forest_night'
    lualine.status()
  end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  use { 'akinsho/nvim-bufferline.lua', config = function()
    -- Enable 24-bit RGB color in the TUI.
    vim.o.termguicolors = true

    require('bufferline').setup({})
  end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  use { 'glepnir/indent-guides.nvim', config = function()
    -- Enable 24-bit RGB color in the TUI.
    vim.o.termguicolors = true

    require('indent_guides').setup({})
  end,
  }

  use { 'nvim-treesitter/nvim-treesitter', config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed      = 'all',
      highlight             = { enable = true },
      incremental_selection = { enable = true },
      indent                = { enable = true },
    })
  end,
  }

  -- Completion {{{1

  use { 'neovim/nvim-lspconfig', config = function()
    local lspconfig           = require('lspconfig')
    local lspconfig_root_path = vim.env.XDG_DATA_HOME .. '/nvim-lspconfig'

    lspconfig.bashls.setup({})

    lspconfig.cssls.setup({})

    lspconfig.diagnosticls.setup({})

    lspconfig.dockerls.setup({})

    lspconfig.efm.setup({})

    lspconfig.elmls.setup({})

    lspconfig.html.setup({})

    lspconfig.jsonls.setup({})

    lspconfig.solargraph.setup({})

    lspconfig.sorbet.setup({})

    lspconfig.sqlls.setup({})

    local sumneko_root_path = lspconfig_root_path .. '/sumneko_lua'
    local sumneko_bin       = sumneko_root_path .. '/bin/macOS/lua-language-server'
    local sumneko_ext       = sumneko_root_path .. '/main.lua'
    lspconfig.sumneko_lua.setup({
      cmd = { sumneko_bin, '-E', sumneko_ext },
      settings = { Lua = { diagnostics = { globals = { 'use', 'vim' } } } },
    })

    lspconfig.terraformls.setup({})

    lspconfig.tsserver.setup({})

    lspconfig.yamlls.setup({})
  end,
  }

  use { 'nvim-lua/completion-nvim', config = function()
    -- Set completeopt to have a better completion experience.
    vim.o.completeopt = table.concat({
      'menuone',
      'noinsert',
      'noselect',
    }, ',')

    -- Avoid showing message extra message when using completion.
    vim.o.shortmess = vim.o.shortmess .. 'c'

    -- Change source whenever current source has no complete items.
    vim.g.completion_auto_change_source = 1

    -- Use completion-nvim in every buffer.
    vim.cmd([[autocmd BufEnter * lua require('completion').on_attach()]])
  end,
  }

end)

-- Folding {{{1

-- vim: foldmethod=marker
