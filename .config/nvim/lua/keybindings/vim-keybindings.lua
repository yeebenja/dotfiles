-- vim-keybindings.lua
-- vim specific keybindings

-- quit
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = '[q]uit' })

-- quit all
vim.keymap.set('n', '<leader>Q', '<cmd>qa<CR>', { desc = '[Q]uit All' })

-- update (write only when there are changes)
vim.keymap.set('n', '<leader>w', '<cmd>update<CR>', { desc = '[w]rite ' })

-- ZZ write and quit buffer

-- buffer delete :bd
vim.keymap.set('n', '<leader>bd', function()
  require('mini.bufremove').delete()
end, { desc = '[b]uffer [d]elete' })

-- set description names for lsp keymaps
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol' })
vim.keymap.set({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, { desc = 'LSP: Code action' })

-- Keybinds to make split navigation easier.
-- Ctrl+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Split buffer Horizontally and Vertically
vim.keymap.set('n', '<leader>ah', '<cmd>sb<CR>', { desc = '[H]orizontal Split' })
vim.keymap.set('n', '<leader>av', '<cmd>vert sb<CR>', { desc = '[V]ertical Split' })

-- Switch/Split alternate buffers
vim.keymap.set('n', '<leader>v', '<cmd>e #<CR>', { desc = 'Switch to Alternate Buffer' })
vim.keymap.set('n', '<leader>V', '<cmd>bot sf #<CR>', { desc = 'Split Alternate Buffer' })

-- Resize buffers
vim.keymap.set('n', '<M-/>', ':vertical resize +5<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<M-.>', ':vertical resize -5<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<M-]>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<M-[>', ':resize -2<CR>', { desc = 'Decrease window height' })
