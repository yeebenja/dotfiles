-- native undotree
vim.cmd 'packadd nvim.undotree'
vim.keymap.set('n', '<leader>u', function()
  require('undotree').open { command = '60vnew' }
end)

-- difftool
vim.cmd 'packadd nvim.difftool'
