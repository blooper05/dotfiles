return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'f3fora/cmp-spell' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-path' },
      { 'jcdickinson/codeium.nvim' },
      { 'neovim/nvim-lspconfig' },
      { 'onsails/lspkind-nvim' },
      { 'ray-x/cmp-treesitter' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'uga-rosa/cmp-dictionary' },
    },
    init = function()
      -- Set completeopt to have a better completion experience.
      vim.opt.completeopt = {
        'menuone',
        'noselect',
      }

      -- Avoid showing extra message when using completion.
      vim.opt.shortmess:append('c')
    end,
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          format = lspkind.cmp_format({
            menu = {
              buffer = '[Buffer]',
              calc = '[Calc]',
              cmdline = '[Cmd]',
              codeium = '[Codeium]',
              dictionary = '[Dictionary]',
              emoji = '[Emoji]',
              luasnip = '[Snippet]',
              nvim_lsp = '[LSP]',
              nvim_lua = '[Lua]',
              path = '[Path]',
              spell = '[Spell]',
              treesitter = '[TS]',
            },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),

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
        }),
        sources = cmp.config.sources({
          { name = 'codeium' },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
          { name = 'treesitter' },
          { name = 'dictionary' },
          { name = 'spell' },
          { name = 'calc' },
        }),
      })

      cmp.setup.filetype({ 'gina-commit', 'gitcommit', 'markdown' }, {
        sources = cmp.config.sources({
          { name = 'codeium' },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'emoji' },
        }, {
          { name = 'buffer' },
          { name = 'treesitter' },
          { name = 'dictionary' },
          { name = 'spell' },
          { name = 'calc' },
        }),
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline({
          ['<C-n>'] = cmp.config.disable,
          ['<C-p>'] = cmp.config.disable,
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp_document_symbol' },
        }, {
          { name = 'buffer' },
        }),
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
          ['<C-n>'] = cmp.config.disable,
          ['<C-p>'] = cmp.config.disable,
        }),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
    event = { 'InsertEnter', 'CmdlineEnter' },
  },

  {
    'uga-rosa/cmp-dictionary',
    init = function()
      vim.opt.spelllang = { 'en_us' }
    end,
    config = function()
      require('cmp_dictionary').switcher({
        spelllang = {
          en_us = '/usr/share/dict/words',
        },
      })
    end,
  },

  {
    'f3fora/cmp-spell',
    dependencies = {
      { 'psliwka/vim-dirtytalk' },
    },
    init = function()
      vim.opt.spelllang = { 'en_us' }

      vim.api.nvim_create_user_command('SpellCheckingToggle', function()
        vim.opt.spell = not vim.api.nvim_win_get_option(0, 'spell')
      end, { force = true })
    end,
  },

  {
    'psliwka/vim-dirtytalk', -- non-lua plugin
    build = ':DirtytalkUpdate',
    init = function()
      vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/site')

      vim.opt.spelllang:append('programming')
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      { 'rafamadriz/friendly-snippets' }, -- non-lua plugin
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()

      local luasnip = require('luasnip')
      local s = luasnip.snippet
      local i = luasnip.insert_node
      local fmt = require('luasnip.extras.fmt').fmt

      luasnip.add_snippets('gina-commit', {
        -- stylua: ignore start
        s('sparkles',            fmt('✨ feat({}): ',     { i(1, 'scope') })),
        s('bug',                 fmt('🐛 fix({}): ',      { i(1, 'scope') })),
        s('ambulance',           fmt('🚑 fix({}): ',      { i(1, 'scope') })),
        s('lock',                fmt('🔒 fix({}): ',      { i(1, 'scope') })),
        s('pencil2',             fmt('✏️  fix({}): ',      { i(1, 'scope') })),
        s('recycle',             fmt('♻️  refactor({}): ', { i(1, 'scope') })),
        s('truck',               fmt('🚚 refactor({}): ', { i(1, 'scope') })),
        s('fire',                fmt('🔥 refactor({}): ', { i(1, 'scope') })),
        s('art',                 fmt('🎨 style({}): ',    { i(1, 'scope') })),
        s('rotating_light',      fmt('🚨 style({}): ',    { i(1, 'scope') })),
        s('zap',                 fmt('⚡️ perf({}): ',     { i(1, 'scope') })),
        s('white_check_mark',    fmt('✅ test({}): ',     { i(1, 'scope') })),
        s('memo',                fmt('📝 docs({}): ',     { i(1, 'scope') })),
        s('bulb',                fmt('💡 docs({}): ',     { i(1, 'scope') })),
        s('green_heart',         fmt('💚 ci({}): ',       { i(1, 'scope') })),
        s('construction_worker', fmt('👷 ci({}): ',       { i(1, 'scope') })),
        s('tada',                fmt('🎉 chore({}): ',    { i(1, 'scope') })),
        s('bookmark',            fmt('🔖 chore({}): ',    { i(1, 'scope') })),
        s('rocket',              fmt('🚀 chore({}): ',    { i(1, 'scope') })),
        s('wrench',              fmt('🔧 chore({}): ',    { i(1, 'scope') })),
        s('hammer',              fmt('🔨 chore({}): ',    { i(1, 'scope') })),
        s('heavy_plus_sign',     fmt('➕ chore({}): ',    { i(1, 'scope') })),
        s('heavy_minus_sign',    fmt('➖ chore({}): ',    { i(1, 'scope') })),
        s('arrow_up',            fmt('⬆️  chore({}): ',    { i(1, 'scope') })),
        s('arrow_down',          fmt('⬇️  chore({}): ',    { i(1, 'scope') })),
        -- stylua: ignore end
      })
    end,
  },

  -- TODO: { 'zbirenbaum/copilot.lua' },
  -- TODO: { 'zbirenbaum/copilot-cmp' },

  {
    'windwp/nvim-autopairs',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      local autopairs = require('nvim-autopairs')

      autopairs.setup({
        check_ts = true,
      })

      local rule = require('nvim-autopairs.rule')
      local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }

      autopairs.add_rules({
        rule(' ', ' '):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2],
          }, pair)
        end),
      })

      for _, bracket in pairs(brackets) do
        autopairs.add_rules({
          rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match('.%' .. bracket[2]) ~= nil
            end)
            :use_key(bracket[2]),
        })
      end
    end,
    event = 'InsertEnter',
  },

  {
    'danymat/neogen',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {
      snippet_engine = 'luasnip',
    },
    cmd = 'Neogen',
    keys = {
      -- stylua: ignore start
      { 'gcd', function() require('neogen').generate() end, silent = true },
      -- stylua: ignore end
    },
  },
}
