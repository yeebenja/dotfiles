-- term.lua

vim.keymap.set('n', '<leader>N', function()
  vim.cmd.term()
end, { desc = '[N]ew Terminal' })
