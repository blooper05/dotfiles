return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      local function start(buf, lang)
        if not vim.treesitter.highlighter.active[buf] then
          vim.treesitter.start(buf, lang)
        end

        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        for _, win in ipairs(vim.fn.win_findbuf(buf)) do
          vim.wo[win][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[win][0].foldmethod = 'expr'
        end
      end

      local available
      local function is_available(lang)
        available = available or require('nvim-treesitter').get_available()
        return vim.tbl_contains(available, lang)
      end

      local installing = {}
      local function install(buf, lang)
        if not is_available(lang) or installing[lang] then
          return
        end

        installing[lang] = true
        require('nvim-treesitter').install(lang):await(function(err)
          installing[lang] = nil

          if err or not vim.api.nvim_buf_is_valid(buf) then
            return
          end

          if vim.treesitter.language.add(lang) then
            start(buf, lang)
          end
        end)
      end

      local function attach(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end

        if vim.treesitter.language.add(lang) then
          start(args.buf, lang)
        else
          install(args.buf, lang)
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('TreesitterStart', {}),
        callback = attach,
      })
    end,
    lazy = false,
  },

  {
    'm-demare/hlargs.nvim',
    config = true,
    event = 'BufReadPost',
  },
}
