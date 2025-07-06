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
vim.keymap.set('n', '<leader>gg', function()
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
-- NOTE: <C-7> and <C-0> don't work with TMUX
vim.keymap.set('n', '<C-7>', function()
  vim.cmd ':BufferPrevious'
end, { desc = 'Buffer Move Previous' })
vim.keymap.set('n', '<C-0>', function()
  vim.cmd ':BufferNext'
end, { desc = 'Buffer Move Next' })

-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree' })

-- Aerial
vim.keymap.set('n', '<leader>aa', '<cmd>AerialToggle!<CR>', { desc = '[A]erial Toggle' })

-- Stay Centered
-- vim.keymap.set({ 'n', 'v' }, '<leader>a2', require('stay-centered').toggle, { desc = 'Toggle stay-centered.nvim' })

vim.keymap.set({ 'n', 'v' }, '<leader>a2', function()
  require('stay-centered').enable()
  -- -@param msg string|string[]
  -- -@param opts? snacks.notify.Opts
  Snacks.notify.notify('Stay-Center.nvim Enabled', { once = false })
end, { desc = 'Enable Cursor Center' })

vim.keymap.set({ 'n', 'v' }, '<leader>a3', function()
  require('stay-centered').disable()
  -- -@param msg string|string[]
  -- -@param opts? snacks.notify.Opts
  Snacks.notify.notify('Stay-Center.nvim Disabled', { once = false })
end, { desc = 'Disable Cursor Center' })

-- Spectre
vim.keymap.set('n', '<leader>i', function()
  Snacks.notifier.notify('Spectre Toggled', 'info', { style = 'compact', timeout = 1000, title = 'Snacks Notifier' })
  require('spectre').toggle()
end, {
  desc = '[I] Toggle Spectre',
})
vim.keymap.set('n', '<leader>ki', function()
  Snacks.notifier.notify('Spectre Current Word Enabled', 'info', { style = 'compact', timeout = 1000, title = 'Snacks Notifier' })
  require('spectre').open_visual { select_word = true }
end, {
  desc = 'Search current word',
})
vim.keymap.set('v', '<leader>ki', function()
  Snacks.notifier.notify('Spectre Current Word Enabled', 'info', { style = 'compact', timeout = 1000, title = 'Snacks Notifier' })
  require('spectre').open_visual()
end, {
  desc = 'Search current word',
})
vim.keymap.set('n', '<leader>kk', function()
  Snacks.notifier.notify('Spectre Current Word Enabled', 'info', { style = 'compact', timeout = 1000, title = 'Snacks Notifier' })
  require('spectre').open_file_search { select_word = true }
end, {
  desc = 'Search on current file',
})

-- lsp-lines
-- lsp-lines enable
vim.keymap.set('n', '<leader>a4', function()
  -- require('lsp_lines').toggle()
  Snacks.notifier.notify('LSP Lines Enabled', 'info', { style = 'compact', timeout = 2000, title = 'Snacks Notifier' })
  vim.diagnostic.config { virtual_lines = true }
  vim.diagnostic.config {
    virtual_text = false,
  }
end, {
  desc = 'LSP Lines Enable',
})

-- lsp-lines disable
vim.keymap.set('n', '<leader>a5', function()
  -- require('lsp_lines').toggle()
  Snacks.notifier.notify('LSP Lines Disabled', 'info', { style = 'compact', timeout = 2000, title = 'Snacks Notifier' })
  vim.diagnostic.config { virtual_lines = false }
  vim.diagnostic.config {
    virtual_text = true,
  }
end, {
  desc = 'LSP Lines Disable',
})

-- Up and Down (my own custon keymappings)
vim.keymap.set('n', '-', '<C-d>', { noremap = true })
vim.keymap.set('v', '-', '<C-d>', { noremap = true })
vim.keymap.set('n', '=', '<C-u>', { noremap = true })
vim.keymap.set('v', '=', '<C-u>', { noremap = true })
