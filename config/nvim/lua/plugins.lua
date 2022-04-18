local fn = vim.fn

local installPath = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local repository  = 'https://github.com/wbthomason/packer.nvim'

if fn.empty(fn.glob(installPath)) > 0 then
  PackerBootstrap = fn.system({ 'git', 'clone', '--depth', '1', repository, installPath })
end

vim.cmd('packadd packer.nvim')

local function packerStartup(use)
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

  for _, plugin in ipairs(require('plugins.appearance'))    do use(plugin) end
  for _, plugin in ipairs(require('plugins.treesitter'))    do use(plugin) end

  for _, plugin in ipairs(require('plugins.lsp'))           do use(plugin) end
  for _, plugin in ipairs(require('plugins.completion'))    do use(plugin) end

  for _, plugin in ipairs(require('plugins.fuzzy_finder'))  do use(plugin) end
  for _, plugin in ipairs(require('plugins.filer'))         do use(plugin) end
  for _, plugin in ipairs(require('plugins.terminal'))      do use(plugin) end

  for _, plugin in ipairs(require('plugins.text_object'))   do use(plugin) end
  for _, plugin in ipairs(require('plugins.editing'))       do use(plugin) end
  for _, plugin in ipairs(require('plugins.search'))        do use(plugin) end

  for _, plugin in ipairs(require('plugins.dap'))           do use(plugin) end
  for _, plugin in ipairs(require('plugins.runner'))        do use(plugin) end

  for _, plugin in ipairs(require('plugins.filetype'))      do use(plugin) end
  for _, plugin in ipairs(require('plugins.vcs'))           do use(plugin) end
  for _, plugin in ipairs(require('plugins.web'))           do use(plugin) end

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
