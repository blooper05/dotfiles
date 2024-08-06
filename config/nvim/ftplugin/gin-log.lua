vim.opt_local.cursorline = true

vim.keymap.set('n', 'p', '<Plug>(gin-action-show:vsplit)', { buffer = true })
vim.keymap.set('n', 'if', '<Plug>(gin-action-fixup:instant-fixup)', { buffer = true })
