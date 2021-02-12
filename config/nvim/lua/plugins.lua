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
  use { 'wbthomason/packer.nvim', opt = true,
    setup = function()
      -- Run :PackerCompile whenever plugins.lua is updated automatically.
      vim.cmd('autocmd MyAutoCmd BufWritePost plugins.lua luafile %:p')
      vim.cmd('autocmd MyAutoCmd BufWritePost plugins.lua PackerCompile')
    end,
  }

  -- Appearance {{{1

  use { 'glepnir/zephyr-nvim',
    config = function()
      -- Assume a dark background.
      vim.o.background = 'dark'

      -- Enable 24-bit RGB color in the TUI.
      vim.o.termguicolors = true

      -- Use zephyr as colorscheme.
      vim.cmd('colorscheme zephyr')
    end,
  }

  use { 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({})
    end,
  }

  use { 'hoob3rt/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      -- Get rid of redundant mode display.
      vim.o.showmode = false

      local lualine = require('lualine')
      lualine.theme = 'OceanicNext'
      lualine.status()
    end,
  }

  use { 'akinsho/nvim-bufferline.lua',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.o.termguicolors = true

      require('bufferline').setup({})
    end,
  }

  use { 'glepnir/indent-guides.nvim',
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.o.termguicolors = true

      require('indent_guides').setup({})
    end,
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed      = 'all',
        highlight             = { enable = true },
        incremental_selection = { enable = true },
        indent                = { enable = true },
      })
    end,
  }

  use { 'norcalli/nvim-colorizer.lua',
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.o.termguicolors = true

      require('colorizer').setup({})
    end,
  }

  use { 'junegunn/goyo.vim', -- non-lua plugin
    requires = {
      { 'junegunn/limelight.vim' },
    },
    config = function()
      vim.cmd('autocmd! User GoyoEnter Limelight')
      vim.cmd('autocmd! User GoyoLeave Limelight!')
    end,
  }

  -- Language Server Protocol {{{1

  use { 'neovim/nvim-lspconfig',
    run = function()
      local lspconfig_root_path = vim.env.XDG_DATA_HOME .. '/nvim-lspconfig'

      execute('!mkdir -p ' .. lspconfig_root_path)

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
    config = function()
      local lspconfig           = require('lspconfig')
      local lspconfig_root_path = vim.env.XDG_DATA_HOME .. '/nvim-lspconfig'

      -- lspconfig.bashls.setup({})

      -- lspconfig.cssls.setup({})

      -- lspconfig.diagnosticls.setup({
      --   filetypes = { 'sh' },
      -- })

      -- lspconfig.dockerls.setup({})

      -- lspconfig.efm.setup({})

      -- lspconfig.elmls.setup({})

      -- lspconfig.gopls.setup({})

      -- lspconfig.html.setup({})

      -- lspconfig.jsonls.setup({})

      -- lspconfig.rls.setup({})

      -- lspconfig.rust_analyzer.setup({})

      -- lspconfig.solargraph.setup({})

      -- lspconfig.sorbet.setup({})

      -- lspconfig.sqlls.setup({})

      -- lspconfig.sqls.setup({})

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

      -- lspconfig.tsserver.setup({})

      -- lspconfig.yamlls.setup({})
    end,
  }

  -- Debug Adapter Protocol {{{1

  use { 'mfussenegger/nvim-dap',
    config = function()
      vim.api.nvim_set_keymap('n', '[dap]',    '<Nop>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>d', '[dap]', {})

      vim.api.nvim_set_keymap('n', '[dap]r', [[<Cmd>lua require('dap').repl.open()<CR>]],         { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[dap]b', [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[dap]c', [[<Cmd>lua require('dap').repl.continue()<CR>]],     { noremap = true, silent = true })
    end,
  }

  use { 'theHamsta/nvim-dap-virtual-text',
    requires = {
      { 'mfussenegger/nvim-dap'           },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      -- Show virtual text for current frame.
      vim.g.dap_virtual_text = true
    end,
  }

  -- Completion {{{1

  use { 'nvim-lua/completion-nvim',
    config = function()
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
      vim.cmd([[autocmd MyAutoCmd BufEnter * lua require('completion').on_attach()]])
    end,
  }

  use { 'norcalli/snippets.nvim',
    requires = {
      { 'nvim-lua/completion-nvim' },
    },
    config = function()
      vim.g.completion_enable_snippet = 'snippets.nvim'

      require('snippets').use_suggested_mappings()
    end,
  }

  use { 'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  }

  -- Fuzzy Finder {{{1

  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim'                         },
      { 'nvim-lua/plenary.nvim'                       },
      { 'kyazdani42/nvim-web-devicons',    opt = true },
      { 'nvim-treesitter/nvim-treesitter', opt = true },
      { 'neovim/nvim-lspconfig',           opt = true },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]', '<Nop>',       { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>u',    '[telescope]', {})

      vim.api.nvim_set_keymap('n', '[telescope]f', [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]g', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]b', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]r', [[<Cmd>lua require('telescope.builtin').registers()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]H', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })

      require('telescope').setup({
        defaults = {
          prompt_position  = 'top',
          sorting_strategy = 'ascending',
          layout_strategy  = 'flex',

          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-c>'] = false,
              ['<Esc>'] = require('telescope.actions').close,
            },
          },
        },
      })
    end,
  }

  use { 'nvim-telescope/telescope-frecency.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'tami5/sql.nvim'                },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]h', [[<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>]], { noremap = true, silent = true })

      require('telescope').load_extension('frecency')
    end,
  }

  use { 'nvim-telescope/telescope-packer.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]p', [[<Cmd>lua require('telescope').extensions.packer.plugins()<CR>]], { noremap = true, silent = true })

      require('telescope').load_extension('packer')
    end,
  }

  use { 'nvim-telescope/telescope-ghq.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]s', [[<Cmd>lua require('telescope').extensions.ghq.list()<CR>]], { noremap = true, silent = true })

      require('telescope').load_extension('ghq')
    end,
  }

  -- File Explorer {{{1

  use { 'kyazdani42/nvim-tree.lua',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[file]',   '<Nop>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>f', '[file]', {})

      vim.api.nvim_set_keymap('n', '[file]c', ':<C-u>NvimTreeToggle<CR>', { noremap = true, silent = true })

      -- Enable 24-bit RGB color in the TUI.
      vim.o.termguicolors = true

      vim.cmd('autocmd MyAutoCmd FileType NvimTree setlocal cursorline')

      vim.g.nvim_tree_width          = 40
      vim.g.nvim_tree_follow         = 1
      vim.g.nvim_tree_indent_markers = 1
      vim.g.nvim_tree_hide_dotfiles  = 1
    end,
  }

  -- Terminal {{{1

  use { 'numtostr/FTerm.nvim',
    config = function()
      vim.fn.nvim_set_keymap('n', '<Leader>t', [[<CMD>lua require('FTerm').toggle()<CR>]], { noremap = true, silent = true })
      vim.fn.nvim_set_keymap('t', '<Leader>t', [[<CMD>lua require('FTerm').toggle()<CR>]], { noremap = true, silent = true })
    end,
  }

  -- Text Object {{{1

  use { 'bkad/CamelCaseMotion', -- non-lua plugin
    config = function()
      vim.g.camelcasemotion_key = ''
    end,
  }

  use { 'andymass/vim-matchup', -- non-lua plugin
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  }

  use { 'haya14busa/vim-operator-flashy', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.api.nvim_set_keymap('',  'y', '<Plug>(operator-flashy)',  {})
      vim.api.nvim_set_keymap('n', 'Y', '<Plug>(operator-flashy)$', {})
    end,
  }

  use { 'rhysd/vim-operator-surround', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.api.nvim_set_keymap('o', 's',  '<Plug>(operator-surround-append)',   { silent = true })
      vim.api.nvim_set_keymap('x', 's',  '<Plug>(operator-surround-append)',   { silent = true })
      vim.api.nvim_set_keymap('',  'ds', '<Plug>(operator-surround-delete)a',  { silent = true })
      vim.api.nvim_set_keymap('',  'cs', '<Plug>(operator-surround-replace)a', { silent = true })
    end,
  }

  use { 'kana/vim-operator-replace', -- non-lua plugin
    requires = {
      { 'kana/vim-operator-user' },
    },
    config = function()
      vim.api.nvim_set_keymap('o', 'p', '<Plug>(operator-replace)', { silent = true })
      vim.api.nvim_set_keymap('x', 'p', '<Plug>(operator-replace)', { silent = true })
    end,
  }

  -- Editing {{{1

  use { 'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language('default', {
        prefer_single_line_comments = true,
        ignore_whitespace           = false,
      })
    end,
  }

  use { 'monaqa/dial.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-a>',  '<Plug>(dial-increment)', {})
      vim.api.nvim_set_keymap('n', '<C-x>',  '<Plug>(dial-decrement)', {})
      vim.api.nvim_set_keymap('v', '<C-a>',  '<Plug>(dial-increment)', {})
      vim.api.nvim_set_keymap('v', '<C-x>',  '<Plug>(dial-decrement)', {})
      vim.api.nvim_set_keymap('v', 'g<C-a>', '<Plug>(dial-increment-additional)', {})
      vim.api.nvim_set_keymap('v', 'g<C-x>', '<Plug>(dial-decrement-additional)', {})

      local dial = require('dial')

      dial.augends.boolean = dial.augends.common.enum_cyclic({
        name    = 'boolean',
        strlist = { 'true', 'false' },
      })
      table.insert(dial.searchlist.normal, dial.augends.boolean)

      dial.augends.git_rebase = dial.augends.common.enum_cyclic({
        name    = 'git_rebase',
        strlist = { 'pick', 'fixup', 'reword', 'edit', 'squash', 'exec', 'break', 'drop', 'label', 'reset', 'merge' },
      })
      table.insert(dial.searchlist.normal, dial.augends.git_rebase)
    end,
  }

  use { 'junegunn/vim-easy-align', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('x', '<Enter>', '<Plug>(EasyAlign)', { silent = true })
    end,
  }

  use { 'ntpeters/vim-better-whitespace', -- non-lua plugin
    config = function()
      -- Strip whitespaces when I save files.
      vim.g.strip_whitespace_on_save = true
      vim.g.strip_whitespace_confirm = false

      vim.g.better_whitespace_filetypes_blacklist = {
        'diff',
        'git',
        'gitcommit',
        'help',
        'markdown',
      }
    end,
  }

  use { 'mbbill/undotree', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('n', '<Space>U', ':<C-u>UndotreeToggle<CR>', { noremap = true, silent = true })
    end,
  }

  use { 'lambdalisue/suda.vim', -- non-lua plugin
    config = function()
      -- Automatically switch a buffer name when the target file is not readable or writable.
      vim.g.suda_smart_edit = true
    end,
  }

  use { 'yuttie/comfortable-motion.vim', -- non-lua plugin
    config = function()
      vim.g.comfortable_motion_friction = 120.0
      vim.g.comfortable_motion_air_drag = 3.0
    end,
  }

  -- Search {{{1

  use { 'kevinhwang91/nvim-hlslens',
    config = function()
      vim.api.nvim_set_keymap('', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
    end,
  }

  use { 'haya14busa/vim-asterisk', -- non-lua plugin
    requires = {
      { 'kevinhwang91/nvim-hlslens' },
    },
    config = function()
      vim.api.nvim_set_keymap('', '*',  [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],  {})
      vim.api.nvim_set_keymap('', '#',  [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],  {})
      vim.api.nvim_set_keymap('', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
    end,
  }

  -- Version Control System {{{1

  use { 'lambdalisue/gina.vim', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('n', '[gina]',   '<Nop>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>g', '[gina]', {})

      vim.api.nvim_set_keymap('n', '[gina]a', ':<C-u>Gina add -- %<CR>',           { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]r', ':<C-u>Gina reset --quiet -- %<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]B', ':<C-u>Gina blame<CR>',              { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]b', ':<C-u>Gina branch --all<CR>',       { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]c', ':<C-u>Gina commit<CR>',             { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]C', ':<C-u>Gina commit --amend<CR>',     { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]l', ':<C-u>Gina log --graph<CR>',        { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]L', ':<C-u>Gina log --graph -- %<CR>',   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]d', ':<C-u>Gina compare<CR>',            { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]D', ':<C-u>Gina compare --cached<CR>',   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]p', ':<C-u>Gina patch<CR>',              { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]R', ':<C-u>Gina reflog<CR>',             { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]s', ':<C-u>Gina status<CR>',             { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]P', ':<C-u>Gina push<CR>',               { noremap = true, silent = true })

      -- gina-buffer-blame specific settings.
      vim.call('gina#custom#action#alias', 'blame', 'preview', 'botright show:commit:preview')
      vim.call('gina#custom#action#alias', 'blame', 'changes', 'botright changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'blame', 'p', [[:<C-u>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'blame', 'c', [[:<C-u>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#execute', 'blame', 'setlocal cursorline')

      -- gina-buffer-branch specific settings.
      vim.call('gina#custom#mapping#nmap', 'branch', 'co', '<Plug>(gina-commit-checkout)')
      vim.call('gina#custom#mapping#nmap', 'branch', 'ct', '<Plug>(gina-commit-checkout-track)')
      vim.call('gina#custom#mapping#nmap', 'branch', 'M',  '<Plug>(gina-branch-move)')
      vim.call('gina#custom#mapping#nmap', 'branch', 'D',  '<Plug>(gina-branch-delete)')
      vim.call('gina#custom#execute', 'branch', 'setlocal cursorline')
      vim.call('gina#custom#command#option', 'branch', '--verbose')

      -- gina-buffer-commit specific settings.
      vim.call('gina#custom#command#option', 'commit', '--verbose')

      -- gina-buffer-log specific settings.
      vim.call('gina#custom#action#alias', 'log', 'preview', 'botright show:commit:preview')
      vim.call('gina#custom#action#alias', 'log', 'changes', 'botright changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'log', 'p', [[:<C-u>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'log', 'c', [[:<C-u>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#execute', 'log', 'setlocal cursorline')

      -- gina-buffer-reflog specific settings.
      vim.call('gina#custom#action#alias', 'reflog', 'preview', 'botright show:commit:preview')
      vim.call('gina#custom#action#alias', 'reflog', 'changes', 'botright changes:of:preview')
      vim.call('gina#custom#mapping#nmap', 'reflog', 'p', [[:<C-u>call gina#action#call('preview')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#mapping#nmap', 'reflog', 'c', [[:<C-u>call gina#action#call('changes')<CR>]], { noremap = true, silent = true })
      vim.call('gina#custom#execute', 'reflog', 'setlocal cursorline')

      -- gina-buffer-status specific settings.
      vim.call('gina#custom#command#option', 'status', '--branch')
      vim.call('gina#custom#command#option', 'status', '--short')
      vim.call('gina#custom#execute', 'status', 'setlocal cursorline')
    end,
  }

  use { 'lewis6991/gitsigns.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      require('gitsigns').setup()
    end,
  }

  -- Runner {{{1

  use { 'dense-analysis/ale', -- non-lua plugin
    config = function()
      -- Run linters only when I save files.
      vim.g.ale_lint_on_text_changed = 'never'
      vim.g.ale_lint_on_insert_leave = false
      vim.g.ale_lint_on_enter        = false

      -- Run formatters when I save files.
      vim.g.ale_fix_on_save = true

      vim.g.ale_fixers = {
        [ '*' ]    = { 'remove_trailing_lines' },
        ruby       = { 'rubocop' },
        javascript = { 'eslint', 'prettier' },
        typescript = { 'eslint', 'prettier' },
        terraform  = { 'terraform' },
      }
    end,
  }

  use { 'thinca/vim-quickrun', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>r', '<Plug>(quickrun)', {})
    end,
  }

  use { 'vim-test/vim-test', -- non-lua plugin
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>c', ':<C-u>TestFile<CR>',    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>n', ':<C-u>TestNearest<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>l', ':<C-u>TestLast<CR>',    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>a', ':<C-u>TestSuite<CR>',   { noremap = true, silent = true })
    end,
  }

  use { 'previm/previm', -- non-lua plugin
    requires = {
      { 'tyru/open-browser.vim' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>p', ':<C-u>PrevimOpen<CR>', { noremap = true, silent = true })
    end,
  }

  -- FileType {{{1

  -- Natural Language {{{2

  use { 'ujihisa/neco-look', -- non-lua plugin
    config = function()
    end,
  }

  use { 'koron/codic-vim', -- non-lua plugin
    config = function()
    end,
  }

  use { 'skanehira/translate.vim', -- non-lua plugin
    config = function()
    end,
  }

  use { 'ishchow/nvim-deardiary',
    config = function()
      require('deardiary.config').journals = {
        {
          path        = '~/.local/share/journals',
          frequencies = { 'daily', 'weekly', 'monthly', 'yearly' },
        },
      }

      vim.cmd([[autocmd MyAutoCmd VimEnter * lua require('deardiary').set_current_journal_cwd()]])
    end,
  }

  -- Markdown {{{2

  use { 'rcmdnk/vim-markdown', -- non-lua plugin
    requires = {
      { 'joker1007/vim-markdown-quote-syntax' },
    },
    config = function()
      -- Disable the folding configuration.
      vim.g.vim_markdown_folding_disabled = true
    end,
  }

  -- PlantUML {{{2

  use { 'aklt/plantuml-syntax', -- non-lua plugin
    config = function()
    end,
  }

  -- Terraform {{{2

  use { 'hashivim/vim-terraform', -- non-lua plugin
    config = function()
    end,
  }

  -- nginx {{{2
  use { 'chr4/nginx.vim', -- non-lua plugin
    config = function()
    end,
  }

  -- CSV {{{2

  use { 'mechatroner/rainbow_csv', -- non-lua plugin
    config = function()
    end,
  }

  -- Web Service {{{1

  use { 'pwntester/octo.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[octo]',       '<Nop>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]G', '[octo]', {})

      vim.api.nvim_set_keymap('n', '[octo]i', ':<C-u>Octo issue list states=OPEN<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[octo]p', ':<C-u>Octo pr list states=OPEN<CR>',    { noremap = true, silent = true })

      require('telescope').load_extension('octo')
    end,
  }

end)

-- Folding {{{1

-- vim: foldmethod=marker
