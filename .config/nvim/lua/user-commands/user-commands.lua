-- show :messages in a buffer
vim.api.nvim_create_user_command('Messages', function()
  vim.cmd 'enew'
  vim.api.nvim_put(vim.split(vim.fn.execute 'messages', '\n'), 'l', true, false)
  vim.bo.buftype = 'nofile'
end, { desc = 'Load Messages in Buffer' })
