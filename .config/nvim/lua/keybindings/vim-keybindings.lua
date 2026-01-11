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

-- update (write only when there are changes)
vim.keymap.set('n', '<leader>w', function()
  vim.cmd 'update'
end, { desc = '[w]rite ' })

-- ZZ write and quit buffer

-- buffer delete :bd
vim.keymap.set('n', '<leader>bd', function()
  require('mini.bufremove').delete()
end, { desc = '[b]uffer [d]elete' })

-- Remove the default gr mappings for [G]oto [R]eference keymap
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grt')
vim.keymap.del('n', 'gra')
vim.keymap.del('x', 'gra')

-- Keybinds to make split navigation easier.
-- Ctrl+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Split buffer Horizontally and Vertically
vim.keymap.set('n', '<leader>ah', '<cmd>sb<CR>', { desc = '[H]orizontal Split' })
vim.keymap.set('n', '<leader>av', '<cmd>vert sb<CR>', { desc = '[V]ertical Split' })
