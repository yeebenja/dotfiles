-- keybindings.lua

-- Persistence keybindings
-- load the session for the current directory
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

-- Notifier
vim.keymap.set('n', '<leader>an', function()
  local Snacks = require 'snacks'
  Snacks.notifier.show_history()
end, { desc = '[N]otification History' })

-- Neogit
vim.keymap.set('n', '<leader>n', function()
  local neogit = require 'neogit'
  neogit.open()
end, { desc = '[N]eogit' })

-- Gitsigns
vim.keymap.set('n', '<leader>a1', function()
  vim.cmd ':Gitsigns toggle_signs'
end, { desc = '[1] Toggle Git-signs Column' })

-- Oil
vim.keymap.set('n', '<leader>o', function()
  vim.cmd ':Oil'
end, { desc = '[o]il' })

vim.keymap.set('n', '<leader>O', function()
  vim.cmd ':Oil --float'
end, { desc = '[O]il Floating Window' })

-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree' })

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

-- tiny inclinde diagnostics
vim.keymap.set('n', '<leader>a3', function()
  vim.cmd 'TinyInlineDiag toggle'
end, {
  desc = 'Tiny Incline Diagnostics Toggle',
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

-- git-worktree
vim.keymap.set('n', '<leader>gwa', function()
  require('telescope').extensions.git_worktree.create_git_worktree()
end, { desc = 'Git Worktree [A]dd' })

vim.keymap.set('n', '<leader>gwd', function()
  require('telescope').extensions.git_worktree.git_worktrees()
  -- NOTE:
  -- <Enter> - switches to that worktree
  -- <c-d> - deletes that worktree
  -- <c-f> - toggles forcing of the next deletion
end, { desc = 'Git Worktree Switch/[D]elete' })

-- nvim-dap
vim.keymap.set('n', '<F5>', function()
  require('dap').continue()
end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', function()
  require('dap').step_into()
end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', function()
  require('dap').step_over()
end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', function()
  require('dap').step_out()
end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>bb', function()
  require('dap').toggle_breakpoint()
end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })
vim.keymap.set('n', '<F7>', function()
  require('dapui').toggle()
end, { desc = 'Debug: Toggle DAP UI' })

-- conform.nvim
vim.keymap.set('n', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
  Snacks.notifier.notify('Formatted Buffer', 'info', { style = 'compact', timeout = 2000, title = 'Conform.nvim' })
  print 'Formatted Buffer'
end, { desc = '[F]ormat Buffer' })

vim.keymap.set('n', '<leader>F', function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  if vim.g.disable_autoformat then
    Snacks.notifier.notify('Disabled Format-On-Save', 'info', { style = 'compact', timeout = 2000, title = 'Conform.nvim' })
    print 'Disabled Format-On-Save'
  else
    Snacks.notifier.notify('Enabled Format-On-Save', 'info', { style = 'compact', timeout = 2000, title = 'Conform.nvim' })
    print 'Enabled Format-On-Save'
  end
end, { desc = 'Toggle [F]ormat-On-Save for all Buffers' })

-- scratch.nvim
vim.keymap.set('n', '<leader>.', '<cmd>Scratch<cr>', { desc = 'New Scratch Buffer' })
vim.keymap.set('n', '<leader>>', '<cmd>ScratchOpen<cr>', { desc = 'Search Scratch Buffers' })
