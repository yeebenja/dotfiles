-- quickfix-column.lua

-- Autocmd to auto-update signs when quickfix changes
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = '*',
  callback = require('keybindings.quickfix.quickfix-util.quickfix-update-signs').update_qf_signs(),
})

-- Autocmd to also update when opening quickfix window
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = 'quickfix',
  callback = require('keybindings.quickfix.quickfix-util.quickfix-update-signs').update_qf_signs(),
})
