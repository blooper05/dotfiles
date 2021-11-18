-- Plugin Management {{{1

local cmd = vim.cmd
local fn  = vim.fn

local installPath = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(installPath)) > 0 then
  PackerBootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', installPath })
end

cmd('packadd packer.nvim')

cmd('augroup MyAutoCmd')
cmd('autocmd!')
cmd('augroup END')

return require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true,
    setup = function()
      -- Run :PackerCompile whenever plugins.lua is updated automatically.
      vim.cmd('autocmd MyAutoCmd BufWritePost plugins.lua source <afile> | PackerCompile')
    end,
  }

  -- Appearance {{{1

  use { 'glepnir/zephyr-nvim',
    config = function()
      -- Assume a dark background.
      vim.opt.background = 'dark'

      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      -- Use zephyr as colorscheme.
      require('zephyr')
    end,
  }

  use { 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({})
    end,
  }

  use { 'nvim-lualine/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      -- Get rid of redundant mode display.
      vim.opt.showmode = false

      require('lualine').setup({})
    end,
  }

  use { 'akinsho/nvim-bufferline.lua',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('bufferline').setup({})
    end,
  }

  use { 'glepnir/indent-guides.nvim',
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('indent_guides').setup({})
    end,
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed      = 'maintained',
        highlight             = { enable = true },
        incremental_selection = { enable = true },
        indent                = { enable = true },
      })
    end,
  }

  use { 'norcalli/nvim-colorizer.lua',
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('colorizer').setup({})
    end,
  }

  use { 'Pocco81/TrueZen.nvim',
    requires = {
      { 'folke/twilight.nvim' },
    },
    config = function()
      require('true-zen').setup({
        integrations = {
          gitsigns        = true,
          nvim_bufferline = true,
          twilight        = true,
          lualine         = true,
        },
      })
    end,
  }

  use { 'rcarriga/nvim-notify',
    config = function()
    end,
  }

  -- Language Server Protocol {{{1

  use { 'neovim/nvim-lspconfig',
    config = function()
    end,
  }

  use { 'kabouzeid/nvim-lspinstall',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      local lspinstall = require('lspinstall')

      lspinstall.setup({})

      local function setup_servers()
        local servers = lspinstall.installed_servers()
        for _, server in pairs(servers) do
          require('lspconfig')[server].setup({
            settings = {
              Lua = { diagnostics = { globals = { 'use', 'vim' } } },
            },
          })
        end
      end

      setup_servers()

      lspinstall.post_install_hook = function()
        setup_servers()
        vim.cmd('bufdo e')
      end
    end,
  }

  use { 'glepnir/lspsaga.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      require('lspsaga').init_lsp_saga({})
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

  use { 'hrsh7th/nvim-compe',
    config = function()
      -- Set completeopt to have a better completion experience.
      vim.opt.completeopt = {
        'menuone',
        'noselect',
      }

      -- Avoid showing message extra message when using completion.
      vim.opt.shortmess:append('c')

      require('compe').setup({
        source = {
          path            = true;
          buffer          = true;
          tags            = true;
          spell           = true;
          calc            = true;
          emoji           = true;
          nvim_lsp        = true;
          nvim_lua        = true;
          snippets_nvim   = true;
          nvim_treesitter = true;
        };
      })

      vim.api.nvim_set_keymap('i', '<C-Space>', [[compe#complete()]],              { noremap = true, silent = true, expr = true })
      vim.api.nvim_set_keymap('i', '<CR>',      [[compe#confirm('<CR>')]],         { noremap = true, silent = true, expr = true })
      vim.api.nvim_set_keymap('i', '<C-e>',     [[compe#close('<C-e>')]],          { noremap = true, silent = true, expr = true })
      vim.api.nvim_set_keymap('i', '<C-f>',     [[compe#scroll({ 'delta': +4 })]], { noremap = true, silent = true, expr = true })
      vim.api.nvim_set_keymap('i', '<C-d>',     [[compe#scroll({ 'delta': -4 })]], { noremap = true, silent = true, expr = true })
    end,
  }

  use { 'norcalli/snippets.nvim',
    requires = {
      { 'hrsh7th/nvim-compe' },
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
          sorting_strategy = 'ascending',
          layout_strategy  = 'flex',

          layout_config = {
            prompt_position = 'top',
          },

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
      vim.opt.termguicolors = true

      vim.cmd('autocmd MyAutoCmd FileType NvimTree setlocal cursorline')

      vim.g.nvim_tree_width          = 40
      vim.g.nvim_tree_follow         = 1
      vim.g.nvim_tree_indent_markers = 1
      vim.g.nvim_tree_hide_dotfiles  = 1
    end,
  }

  use { 'ahmedkhalf/project.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      vim.g.nvim_tree_update_cwd      = 1
      vim.g.nvim_tree_respect_buf_cwd = 1

      require('project_nvim').setup({})

      require('telescope').load_extension('projects')
    end,
  }

  -- Terminal {{{1

  use { 'numtostr/FTerm.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>t', [[<CMD>lua require('FTerm').toggle()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<Leader>t', [[<CMD>lua require('FTerm').toggle()<CR>]], { noremap = true, silent = true })
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

      dial.augends['custom#boolean'] = dial.common.enum_cyclic({
        name    = 'boolean',
        strlist = { 'true', 'false' },
      })
      table.insert(dial.config.searchlist.normal, 'custom#boolean')

      dial.augends['custom#git_rebase'] = dial.common.enum_cyclic({
        name    = 'git_rebase',
        strlist = { 'pick', 'fixup', 'reword', 'edit', 'squash', 'exec', 'break', 'drop', 'label', 'reset', 'merge' },
      })
      table.insert(dial.config.searchlist.normal, 'custom#git_rebase')
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
        'packer',
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

  use { 'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({})
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
      -- vim.api.nvim_set_keymap('n', '[gina]P', ':<C-u>Gina push<CR>',               { noremap = true, silent = true })

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
        [ '*' ]         = { 'remove_trailing_lines' },
        ruby            = { 'rubocop' },
        json            = { 'eslint', 'prettier' },
        javascript      = { 'eslint', 'prettier' },
        typescript      = { 'eslint', 'prettier' },
        typescriptreact = { 'eslint', 'prettier' },
        vue             = { 'eslint', 'prettier' },
        terraform       = { 'terraform' },
      }

      -- Run linters or formatters via Docker.
      local pwd = vim.api.nvim_call_function('getcwd', {})

      vim.g.ale_ruby_rubocop_executable = 'docker-rubocop'

      vim.g.ale_filename_mappings = {
        ruby = { { pwd, '/app' } },
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
      { 'godlygeek/tabular'                   },
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
      { 'nvim-telescope/telescope.nvim'            },
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[octo]',       '<Nop>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]G', '[octo]', {})

      vim.api.nvim_set_keymap('n', '[octo]i', ':<C-u>Octo issue list<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[octo]p', ':<C-u>Octo pr list<CR>',    { noremap = true, silent = true })

      require('octo').setup({})
    end,
  }

  -- Plugin Management {{{1
  if PackerBootstrap then
    require('packer').sync()
  end

end)

-- Folding {{{1

-- vim: foldmethod=marker
