-- keybindings.lua

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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

-- Toggle wrapping text
vim.keymap.set('n', '<leader>aw', '<cmd>set wrap!<CR>', { desc = '[W]rap Text Toggle' })

-- Snacks
local Snacks = require 'snacks'
vim.keymap.set('n', '<leader>an', function()
  Snacks.notifier.show_history() -- NOTE: Example of using Lua function
end, { desc = '[N]otification History' })

-- Neogit
vim.keymap.set('n', '<leader>ag', function()
  local neogit = require 'neogit'
  neogit.open()
end, { desc = '[G]it' })

-- Gitsigns
vim.keymap.set('n', '<leader>a1', function()
  vim.cmd ':Gitsigns toggle_signs'
end, { desc = '[1] Toggle Git-signs Column' })

-- Hop
-- FIXME: figure out what these two variables do later
-- local hop = require 'hop'
-- local directions = require('hop.hint').HintDirection
vim.keymap.set('n', '<leader>l', function()
  vim.cmd ':HopWord'
end, { desc = '[L] Find Word' })

-- Oil
vim.keymap.set('n', '<leader>o', function()
  vim.cmd ':Oil'
end, { desc = '[O]il' })

-- Barbar
-- FIXME: Doesn't work anymore
vim.keymap.set('n', '<C-7>', function()
  vim.cmd ':BufferPrevious'
end, { desc = 'Buffer Move Previous' })
vim.keymap.set('n', '<C-0>', function()
  vim.cmd ':BufferNext'
end, { desc = 'Buffer Move Next' })

-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree' })
