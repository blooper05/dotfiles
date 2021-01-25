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

  -- Language Server Protocol {{{1

  use { 'neovim/nvim-lspconfig', config = function()
    local lspconfig           = require('lspconfig')
    local lspconfig_root_path = vim.env.XDG_DATA_HOME .. '/nvim-lspconfig'

    lspconfig.bashls.setup({})

    lspconfig.cssls.setup({})

    lspconfig.diagnosticls.setup({
      filetypes = { 'sh' },
    })

    lspconfig.dockerls.setup({})

    lspconfig.efm.setup({})

    lspconfig.elmls.setup({})

    lspconfig.gopls.setup({})

    lspconfig.html.setup({})

    lspconfig.jsonls.setup({})

    lspconfig.rls.setup({})

    lspconfig.rust_analyzer.setup({})

    lspconfig.solargraph.setup({})

    lspconfig.sorbet.setup({})

    lspconfig.sqlls.setup({})

    local sumneko_root_path = lspconfig_root_path .. '/sumneko_lua'
    local sumneko_bin       = sumneko_root_path .. '/extension/server/bin/macOS/lua-language-server'
    local sumneko_ext       = sumneko_root_path .. '/extension/server/main.lua'
    lspconfig.sumneko_lua.setup({
      cmd = { sumneko_bin, '-E', sumneko_ext },
      settings = { Lua = { diagnostics = { globals = { 'use', 'vim' } } } },
    })

    local terraformls_root_path = lspconfig_root_path .. '/terraformls'
    local terraformls_bin       = terraformls_root_path .. '/terraform-ls'
    lspconfig.terraformls.setup({
      cmd = { terraformls_bin, 'serve' },
    })

    lspconfig.tsserver.setup({})

    lspconfig.yamlls.setup({})
  end,
    run = function()
      local lspconfig_root_path = vim.env.XDG_DATA_HOME .. '/nvim-lspconfig'

      local sumneko_root_path = lspconfig_root_path .. '/sumneko_lua'
      local sumneko_bin       = sumneko_root_path .. '/extension/server/bin/macOS/lua-language-server'
      local sumneko_url       = 'https://github.com/sumneko/vscode-lua/releases/download/v1.11.2/lua-1.11.2.vsix'

      execute('!curl -sLJ -o /tmp/sumneko_lua.vsix ' .. sumneko_url)
      execute('!unzip -oq /tmp/sumneko_lua.vsix -d ' .. sumneko_root_path)
      execute('!rm -f /tmp/sumneko_lua.vsix')
      execute('!chmod +x ' .. sumneko_bin)

      local terraformls_root_path = lspconfig_root_path .. '/terraformls'
      local terraformls_url       = 'https://github.com/hashicorp/terraform-ls/releases/download/v0.12.1/terraform-ls_0.12.1_darwin_amd64.zip'

      execute('!curl -sLJ -o /tmp/terraformls.zip ' .. terraformls_url)
      execute('!unzip -oq /tmp/terraformls.zip -d ' .. terraformls_root_path)
      execute('!rm -f /tmp/terraformls.zip')
    end,
  }

  -- Completion {{{1

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

  use { 'windwp/nvim-autopairs', config = function()
    require('nvim-autopairs').setup({})
  end,
  }

  -- Search {{{1

  use { 'kevinhwang91/nvim-hlslens', config = function()
    vim.api.nvim_set_keymap('', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
  end,
  }

  use { 'haya14busa/vim-asterisk', config = function()
    vim.api.nvim_set_keymap('', '*',  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],  {})
    vim.api.nvim_set_keymap('', '#',  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],  {})
    vim.api.nvim_set_keymap('', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
    vim.api.nvim_set_keymap('', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
  end,
    requires = { 'kevinhwang91/nvim-hlslens' },
  }

end)

-- Folding {{{1

-- vim: foldmethod=marker
