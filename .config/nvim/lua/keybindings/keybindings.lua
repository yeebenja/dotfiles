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

-- Harpoon 2 keybindings
vim.keymap.set('n', '<leader>h', function()
  local harpoon = require 'harpoon'
  harpoon:list():add()
  Snacks.notifier.notify('Added to Harpoon', 'info', { style = 'compact', timeout = 2000, title = 'Snacks Notifier' })
end, { desc = '[H]arpoon Add' })

vim.keymap.set('n', '<C-e>', function() -- <C-e> is okay to be overwritten, originally <C-e> goes one line down
  local harpoon = require 'harpoon'
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon List' })

vim.keymap.set('n', '<C-1>', function()
  local harpoon = require 'harpoon'
  harpoon:list():select(1)
end, { desc = 'Harpoon [1]' })

vim.keymap.set('n', '<C-2>', function()
  local harpoon = require 'harpoon'
  harpoon:list():select(2)
end, { desc = 'Harpoon [2]' })

vim.keymap.set('n', '<C-3>', function() -- get rid of other keymap
  local harpoon = require 'harpoon'
  harpoon:list():select(3)
end, { desc = 'Harpoon [3]' })

vim.keymap.set('n', '<C-4>', function() -- get rid of other keymap
  local harpoon = require 'harpoon'
  harpoon:list():select(4)
end, { desc = 'Harpoon [4]' })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<C-S-P>', function()
  local harpoon = require 'harpoon'
  harpoon:list():prev()
end)
vim.keymap.set('n', '<C-S-N>', function()
  local harpoon = require 'harpoon'
  harpoon:list():next()
end)

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

-- Hop DISABLED
-- FIXME: figure out what these two variables do later
-- local hop = require 'hop'
-- local directions = require('hop.hint').HintDirection
-- vim.keymap.set('n', '<leader>l', function()
--   vim.cmd ':HopWord'
-- end, { desc = '[L] Find Word' })

-- Oil
vim.keymap.set('n', '<leader>o', function()
  vim.cmd ':Oil'
end, { desc = '[o]il' })

vim.keymap.set('n', '<leader>O', function()
  vim.cmd ':Oil --float'
end, { desc = '[O]il Floating Window' })

-- Barbar DISABLED
-- NOTE: <C-7> and <C-0> don't work with TMUX
-- vim.keymap.set('n', '<C-7>', function()
--   vim.cmd ':BufferPrevious'
-- end, { desc = 'Buffer Move Previous' })
-- vim.keymap.set('n', '<C-0>', function()
--   vim.cmd ':BufferNext'
-- end, { desc = 'Buffer Move Next' })

-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree' })

-- Aerial DISABLED
-- vim.keymap.set('n', '<leader>aa', '<cmd>AerialToggle!<CR>', { desc = '[A]erial Toggle' })

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

-- Spectre
-- vim.keymap.set('n', '<leader>i', function()
--   Snacks.notifier.notify('Spectre Toggled', 'info', { style = 'compact', timeout = 1000, title = 'Snacks Notifier' })
--   require('spectre').toggle()
-- end, {
--   desc = '[I] Toggle Spectre',
-- })
-- vim.keymap.set('n', '<leader>ki', function()
--   Snacks.notifier.notify('Spectre Current Word Enabled', 'info', { style = 'compact', timeout = 1000, title = 'Snacks Notifier' })
--   require('spectre').open_visual { select_word = true }
-- end, {
--   desc = '(Spectre) Search current word',
-- })
-- vim.keymap.set('v', '<leader>ki', function()
--   Snacks.notifier.notify('Spectre Current Word Enabled', 'info', { style = 'compact', timeout = 1000, title = 'Snacks Notifier' })
--   require('spectre').open_visual()
-- end, {
--   desc = '(Spectre) Search current word',
-- })
-- vim.keymap.set('n', '<leader>kk', function()
--   Snacks.notifier.notify('Spectre Current Word Enabled', 'info', { style = 'compact', timeout = 1000, title = 'Snacks Notifier' })
--   require('spectre').open_file_search { select_word = true }
-- end, {
--   desc = 'Search on current file',
-- })

-- DISABLED lsp-lines toggle
-- vim.keymap.set('n', '<leader>a3', function()
--   local config = vim.diagnostic.config()
--   local is_lines_enabled = config.virtual_lines
--
--   if is_lines_enabled then
--     Snacks.notifier.notify('LSP Lines Disabled', 'info', { style = 'compact', timeout = 2000, title = 'Snacks Notifier' })
--     vim.diagnostic.config { virtual_lines = false, virtual_text = true }
--   else
--     Snacks.notifier.notify('LSP Lines Enabled', 'info', { style = 'compact', timeout = 2000, title = 'Snacks Notifier' })
--     vim.diagnostic.config { virtual_lines = true, virtual_text = false }
--   end
-- end, {
--   desc = 'LSP Lines Toggle',
-- })

-- tiny inclinde diagnostics
vim.keymap.set('n', '<leader>a3', function()
  vim.cmd 'TinyInlineDiag toggle'
end, {
  desc = 'Tiny Incline Diagnostics Toggle',
})

-- Up and Down (my own custon keymappings)
vim.keymap.set('n', '-', '<C-d>', { noremap = true })
vim.keymap.set('v', '-', '<C-d>', { noremap = true })
vim.keymap.set('n', '=', '<C-u>', { noremap = true })
vim.keymap.set('v', '=', '<C-u>', { noremap = true })

-- toggle diagnostics
local isLspDiagnosticsVisible = true
vim.keymap.set('n', '<leader>a4', function()
  -- toggle the state
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible

  -- apply the new state
  vim.diagnostic.config {
    virtual_text = isLspDiagnosticsVisible,
    underline = isLspDiagnosticsVisible,
    -- signs = isLspDiagnosticsVisible -- do i need this? figure out later
  }

  -- notify user
  if isLspDiagnosticsVisible then
    Snacks.notifier.notify('Showing Diagnostics', 'info', { style = 'compact', timeout = 2000, title = 'Snacks Notifier' })
  else
    Snacks.notifier.notify('Hiding Diagnostics', 'info', { style = 'compact', timeout = 2000, title = 'Snacks Notifier' })
  end
end, {
  desc = 'Show/Hide Diagnostics Toggle',
})

-- Leap
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>l', '<Plug>(leap)', { desc = '[l] Leap current window' })
vim.keymap.set('n', '<leader>L', '<Plug>(leap-from-window)', { desc = '[L] Leap to another window' })
vim.keymap.set({ 'n', 'o' }, 'gs', function()
  require('leap.remote').action {
    -- Automatically enter Visual mode when coming from Normal.
    input = vim.fn.mode(true):match 'o' and '' or 'v',
  }
end, { desc = 'leap remote gs' })
-- Forced linewise version (`gS{leap}jjy`):
vim.keymap.set({ 'n', 'o' }, 'gS', function()
  require('leap.remote').action { input = 'V' }
end, { desc = 'leap remote gS' })

-- leetcode.nvim
vim.keymap.set('n', '<leader>2;', '<cmd>Leet run<CR>', { desc = '[;] LeetCode Run' })
vim.keymap.set('n', '<leader>2<CR>', '<cmd>Leet submit<CR>', { desc = '[CR] LeetCode Submit' })
vim.keymap.set('n', '<leader>2c', '<cmd>Leet console<CR>', { desc = '[C] LeetCode Console' })
vim.keymap.set('n', '<leader>2l', '<cmd>Leet list<CR>', { desc = '[l] LeetCode List' })

-- tree split join
vim.keymap.set({ 'n', 'v' }, '<leader>sj', function()
  -- vim.cmd 'TSJToggle'
  local treesj = require 'treesj'
  treesj.toggle()
end, { desc = 'Tree Split/Join' })

-- mini bufremove
vim.api.nvim_create_user_command('Bd', function(opts)
  require('mini.bufremove').delete(0, opts.bang)
end, { bang = true })
-- remap this to :bd
vim.cmd [[
  cnoreabbrev bd Bd
  cnoreabbrev bdelete Bd
]]

-- blame.nvim
vim.keymap.set({ 'n' }, '<leader>gb', function()
  vim.cmd ':BlameToggle window'
end, { desc = 'Git [B]lame Toggle' })

-- diffview
vim.keymap.set({ 'n' }, '<leader>do', function()
  vim.cmd ':DiffviewOpen'
end, { desc = 'Diffview [O]pen' })

vim.keymap.set({ 'n' }, '<leader>dc', function()
  vim.cmd ':DiffviewClose'
end, { desc = 'Diffview [C]lose' })

-- date time
vim.keymap.set('n', '<leader>dt', function()
  local date = os.date '%Y-%m-%d %H:%M:%S'
  vim.api.nvim_put({ tostring(date) }, 'c', true, true)
end, { desc = '[D]ate/[T]ime Insert' })

-- git-worktree
vim.keymap.set('n', '<leader>wa', function()
  require('telescope').extensions.git_worktree.create_git_worktree()
end, { desc = 'Git Worktree [A]dd' })

vim.keymap.set('n', '<leader>wd', function()
  require('telescope').extensions.git_worktree.git_worktrees()
  -- NOTE:
  -- <Enter> - switches to that worktree
  -- <c-d> - deletes that worktree
  -- <c-f> - toggles forcing of the next deletion
end, { desc = 'Git Worktree Switch/[D]elete' })
