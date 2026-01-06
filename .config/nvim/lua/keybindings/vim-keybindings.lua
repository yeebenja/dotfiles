-- vim-keybindings.lua
-- vim specific keybindings

-- quit
vim.keymap.set('n', '<leader>q', function()
  vim.cmd 'q'
end, { desc = '[q]uit' })

-- quit all
vim.keymap.set('n', '<leader>Q', function()
  vim.cmd 'qa'
end, { desc = '[Q]uit All' })
