-- Plugin Management {{{1

local fn = vim.fn

local installPath = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local repository  = 'https://github.com/wbthomason/packer.nvim'

if fn.empty(fn.glob(installPath)) > 0 then
  PackerBootstrap = fn.system({ 'git', 'clone', '--depth', '1', repository, installPath })
end

vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true,
    setup = function()
      -- Run :PackerCompile whenever plugins.lua is updated automatically.
      local autoPackerCompile = vim.api.nvim_create_augroup('AutoPackerCompile', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePost', {
        group   = autoPackerCompile,
        pattern = 'plugins.lua',
        command = 'source <afile> | PackerCompile',
      })
    end,
  }

  -- Appearance {{{1

  use { 'EdenEast/nightfox.nvim',
    config = function()
      -- Assume a dark background.
      vim.opt.background = 'dark'

      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      -- Use nordfox as colorscheme.
      vim.cmd('colorscheme nordfox')
    end,
  }

  use { 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({})
    end,
  }

  use { 'nvim-lualine/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-tree.lua',     opt = true },
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      -- Get rid of redundant mode display.
      vim.opt.showmode = false

      require('lualine').setup({
        options = {
          globalstatus = true,
        },
        extensions = {
          'nvim-tree',
        },
      })
    end,
  }

  use { 'akinsho/bufferline.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('bufferline').setup({})
    end,
  }

  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      require('indent_blankline').setup({})
    end,
  }

  use { 'sunjon/shade.nvim',
    config = function()
      require('shade').setup({})
    end,
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed      = 'all',
        highlight             = { enable = true },
        incremental_selection = { enable = true },
        indent                = { enable = false },
      })
    end,
  }

  use { 'yioneko/nvim-yati',
    requires = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        yati = { enable = true },
      })
    end,
  }

  use { 'm-demare/hlargs.nvim',
    requires = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require('hlargs').setup({})
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
      require('notify').setup({})
    end,
  }

  -- Language Server Protocol {{{1

  use { 'williamboman/nvim-lsp-installer',
    requires = {
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      local installer = require('nvim-lsp-installer.servers')
      local servers   = installer.get_available_server_names()

      for _, name in pairs(servers) do
        local serverAvailable, server = installer.get_server(name)

        if serverAvailable then
          server:on_ready(function()
            local opts = {}

            if server.name == 'sumneko_lua' then
              opts.settings = { Lua = { diagnostics = { globals = { 'use', 'vim' } } } }
            end

            server:setup(opts)
          end)

          if not server:is_installed() then
            server:install()
          end
        end
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
      require('nvim-dap-virtual-text').setup({})
    end,
  }

  -- Completion {{{1

  use { 'hrsh7th/nvim-cmp',
    requires = {
      { 'neovim/nvim-lspconfig'    },
      { 'L3MON4D3/LuaSnip'         },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-buffer'       },
      { 'hrsh7th/cmp-calc'         },
      { 'hrsh7th/cmp-cmdline',     },
      { 'hrsh7th/cmp-emoji'        },
      { 'hrsh7th/cmp-nvim-lsp'     },
      { 'hrsh7th/cmp-nvim-lua'     },
      { 'hrsh7th/cmp-path'         },
      { 'onsails/lspkind-nvim'     },
    },
    config = function()
      -- Set completeopt to have a better completion experience.
      vim.opt.completeopt = {
        'menuone',
        'noselect',
      }

      -- Avoid showing message extra message when using completion.
      vim.opt.shortmess:append('c')

      local cmp     = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-d>']     = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4),  { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(),      { 'i', 'c' }),
          ['<C-e>']     = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources({
          { name = 'luasnip'  },
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer'   },
          { name = 'calc'     },
          { name = 'emoji'    },
          { name = 'nvim_lua' },
        }),
        formatting = {
          format = require('lspkind').cmp_format({
            menu = ({
              buffer   = '[Buffer]',
              calc     = '[Calc]',
              cmdline  = '[Cmd]',
              emoji    = '[Emoji]',
              luasnip  = '[Snippet]',
              nvim_lsp = '[LSP]',
              nvim_lua = '[Lua]',
              path     = '[Path]',
            }),
          }),
        },
      })

      cmp.setup.cmdline('/', {
        sources = { { name = 'buffer' } },
      })

      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path'    },
        }, {
          { name = 'cmdline' },
        }),
      })

      -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup({
      --   capabilities = capabilities,
      -- })
    end,
  }

  use { 'L3MON4D3/LuaSnip',
    requires = {
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      require('luasnip/loaders/from_vscode').lazy_load()
    end,
  }

  use { 'windwp/nvim-autopairs',
    config = function()
      local autopairs = require('nvim-autopairs')
      local rule = require('nvim-autopairs.rule')

      autopairs.setup({})

      autopairs.add_rules({
        rule(' ', ' '):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),

        rule('( ', ' )')
          :with_pair(function() return false end)
          :with_move(function(opts)
            return opts.prev_char:match('.%)') ~= nil
          end)
          :use_key(')'),

        rule('{ ', ' }')
          :with_pair(function() return false end)
          :with_move(function(opts)
            return opts.prev_char:match('.%}') ~= nil
          end)
          :use_key('}'),

        rule('[ ', ' ]')
          :with_pair(function() return false end)
          :with_move(function(opts)
            return opts.prev_char:match('.%]') ~= nil
          end)
          :use_key(']'),
      })
    end,
  }

  -- Fuzzy Finder {{{1

  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim'                       },
      { 'kyazdani42/nvim-web-devicons',    opt = true },
      { 'nvim-treesitter/nvim-treesitter', opt = true },
      { 'neovim/nvim-lspconfig',           opt = true },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]', '<Nop>',       { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>u',    '[telescope]', {})

      vim.api.nvim_set_keymap('n', '[telescope]f', [[<Cmd>lua require('telescope.builtin').git_files()<CR>]],    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]F', [[<Cmd>lua require('telescope.builtin').file_browser()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]g', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]],    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]B', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],      { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]R', [[<Cmd>lua require('telescope.builtin').registers()<CR>]],    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]H', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]],    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]M', [[<Cmd>lua require('telescope.builtin').man_pages()<CR>]],    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[telescope]u', [[<Cmd>lua require('telescope.builtin').resume()<CR>]],       { noremap = true, silent = true })

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
              ['<Esc>'] = 'close',
            },
          },
        },
      })
    end,
  }

  use { 'nvim-telescope/telescope-frecency.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'tami5/sqlite.lua'              },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[telescope]h', [[<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>]], { noremap = true, silent = true })

      require('telescope').load_extension('frecency')
    end,
  }

  use { 'nvim-telescope/telescope-packer.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'wbthomason/packer.nvim'        },
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
      { 'ahmedkhalf/project.nvim'                  },
      { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[file]',   '<Nop>',  { noremap = true })
      vim.api.nvim_set_keymap('n', '<Space>f', '[file]', {})

      vim.api.nvim_set_keymap('n', '[file]c', ':<C-u>NvimTreeToggle<CR>', { noremap = true, silent = true })

      -- Enable 24-bit RGB color in the TUI.
      vim.opt.termguicolors = true

      -- Change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
      vim.g.nvim_tree_respect_buf_cwd = 1

      local cursorline = vim.api.nvim_create_augroup('cursorline', { clear = true })
      vim.api.nvim_create_autocmd('BufWinEnter', {
        group   = cursorline,
        pattern = 'NvimTree',
        command = 'setlocal cursorline',
      })

      require('nvim-tree').setup({
        update_cwd          = true,
        update_focused_file = { enable = true, update_cwd = true },
        view                = { width  = 40 }
      })
    end,
  }

  use { 'ahmedkhalf/project.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('project_nvim').setup({})

      require('telescope').load_extension('projects')
    end,
  }

  -- Terminal {{{1

  use { 'numToStr/FTerm.nvim',
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

      vim.api.nvim_set_keymap('n', '[gina]a', ':<C-u>Gina add -- %:p<CR>',           { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]r', ':<C-u>Gina reset --quiet -- %:p<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]B', ':<C-u>Gina blame<CR>',                { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]b', ':<C-u>Gina branch --all<CR>',         { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]c', ':<C-u>Gina commit<CR>',               { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]C', ':<C-u>Gina commit --amend<CR>',       { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]l', ':<C-u>Gina log --graph<CR>',          { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]L', ':<C-u>Gina log --graph -- %:p<CR>',   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]d', ':<C-u>Gina compare<CR>',              { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]D', ':<C-u>Gina compare --cached<CR>',     { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]p', ':<C-u>Gina patch %:p<CR>',            { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]R', ':<C-u>Gina reflog<CR>',               { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[gina]s', ':<C-u>Gina status<CR>',               { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '[gina]P', ':<C-u>Gina push<CR>',                 { noremap = true, silent = true })

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
      require('gitsigns').setup({})
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

      local deardiary = vim.api.nvim_create_augroup('deardiary', { clear = true })
      vim.api.nvim_create_autocmd('VimEnter', {
        group   = deardiary,
        callback = function()
          require('deardiary').set_current_journal_cwd()
        end,
      })
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
