-- archived-keybindings.lua
-- NOTE: these are old keybindings that I do not use anymore
-- just keeping them here for reference and memories... :)

vim.keymap.set('n', '<leader>O', function()
  vim.cmd ':Oil --float'
end, { desc = '[O]il Floating Window' })

-- Gitsigns
vim.keymap.set('n', '<leader>a1', function()
  vim.cmd ':Gitsigns toggle_signs'
end, { desc = '[1] Toggle Git-signs Column' })

vim.keymap.set('n', '<leader>gh', function()
  vim.cmd ':Gitsigns toggle_linehl'
  vim.cmd ':Gitsigns toggle_word_diff'
end, { desc = 'Git [H]ighlight Changes (Line and WordDiff)' })

-- Stay Centered
-- Initialize the state variable to match the plugin's default (enabled)
vim.g.stay_centered_enabled = true

vim.keymap.set({ 'n', 'v' }, '<leader>a2', function()
  local stay_centered = require 'stay-centered'

  if vim.g.stay_centered_enabled then
    stay_centered.disable()
    Snacks.notify.notify('Stay-Center.nvim Disabled', { once = false })
    vim.g.stay_centered_enabled = false
  else
    stay_centered.enable()
    Snacks.notify.notify('Stay-Center.nvim Enabled', { once = false })
    vim.g.stay_centered_enabled = true
  end
end, { desc = 'Toggle Cursor Center' })
