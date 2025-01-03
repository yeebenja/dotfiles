-- Keybindings for splitting buffer vertically and horizontally
vim.keymap.set('n', '<leader>ah', '<cmd>sb<CR>', { desc = '[H]orizontal Split' })
vim.keymap.set('n', '<leader>av', '<cmd>vert sb<CR>', { desc = '[V]ertical Split' })

-- Harpoon keybindings
require('telescope').load_extension 'harpoon'
vim.keymap.set('n', '<leader>hx', require('harpoon.mark').add_file, { desc = '[H]arpoon: [X] Add file to marks' })
vim.keymap.set('n', '<leader>hn', require('harpoon.ui').nav_next, { desc = '[H]arpoon: [N]ext mark' })
vim.keymap.set('n', '<leader>hp', require('harpoon.ui').nav_prev, { desc = '[H]arpoon: [P]revious mark' })
vim.keymap.set('n', '<leader>hm', ':Telescope harpoon marks<CR>', { desc = '[H]arpoon [M]arks view' })

-- Persistence keybindings
-- -- load the session for the current directory
vim.keymap.set('n', '<leader>1s', function()
  require('persistence').load()
end, { desc = 'Load Session for Current Directory' })

-- select a session to load
vim.keymap.set('n', '<leader>1S', function()
  require('persistence').select()
end, { desc = 'Select Session to Load' })

-- load the last session
vim.keymap.set('n', '<leader>1l', function()
  require('persistence').load { last = true }
end, { desc = 'Load Last Session' })

-- stop Persistence => session won't be saved on exit
vim.keymap.set('n', '<leader>1d', function()
  require('persistence').stop()
end, { desc = "Stop Persistence. (Session won't be saved on exit)" })

-- Themery
-- vim.keymap.set('n', '<leader>at', function()
--   vim.cmd
-- end, { desc = '[T]hemery' })
