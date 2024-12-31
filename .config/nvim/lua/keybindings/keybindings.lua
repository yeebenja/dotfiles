-- Keybindings for splitting buffer vertically and horizontally
vim.keymap.set('n', '<leader>ah', '<cmd>sb<CR>', { desc = '[H]orizontal Split' })
vim.keymap.set('n', '<leader>av', '<cmd>vert sb<CR>', { desc = '[V]ertical Split' })

-- Harpoon keybindings
require('telescope').load_extension 'harpoon'
vim.keymap.set('n', '<leader>hx', require('harpoon.mark').add_file, { desc = '[H]arpoon: [X] Add file to marks' })
vim.keymap.set('n', '<leader>hn', require('harpoon.ui').nav_next, { desc = '[H]arpoon: [N]ext mark' })
vim.keymap.set('n', '<leader>hp', require('harpoon.ui').nav_prev, { desc = '[H]arpoon: [P]revious mark' })
vim.keymap.set('n', '<leader>hm', ':Telescope harpoon marks<CR>', { desc = '[H]arpoon [M]arks view' })
