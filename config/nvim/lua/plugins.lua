local fn = vim.fn

local installPath = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local repository = 'https://github.com/wbthomason/packer.nvim'

if fn.empty(fn.glob(installPath)) > 0 then
  PackerBootstrap = fn.system({ 'git', 'clone', '--depth', '1', repository, installPath })
end

vim.cmd('packadd packer.nvim')

local function packerStartup(use)
  use({
    'wbthomason/packer.nvim',
    opt = true,
    setup = function()
      -- Run :PackerCompile whenever plugins.lua is updated automatically.
      local autoPackerCompile = vim.api.nvim_create_augroup('AutoPackerCompile', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = autoPackerCompile,
        pattern = 'plugins.lua',
        command = 'source <afile> | PackerCompile',
      })
    end,
  })

  local categories = {
    'appearance',
    'treesitter',
    'lsp',
    'completion',
    'fuzzy_finder',
    'filer',
    'terminal',
    'text_object',
    'editing',
    'search',
    'dap',
    'runner',
    'filetype',
    'vcs',
    'web',
  }

  for _, plugins in ipairs(categories) do
    for _, plugin in ipairs(require('plugins.' .. plugins)) do
      use(plugin)
    end
  end

  if PackerBootstrap then
    require('packer').sync()
  end
end

return require('packer').startup({
  packerStartup,

  config = {
    max_jobs = 8,
  },
})
