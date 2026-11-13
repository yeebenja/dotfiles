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

-- Oil
vim.keymap.set('n', '<leader>o', function()
  vim.cmd ':Oil'
end, { desc = '[o]il' })

-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree' })

-- tiny inline diagnostics
vim.keymap.set('n', '<leader>ad', function()
  vim.cmd 'TinyInlineDiag toggle'
end, {
  desc = 'Tiny Inline [D]iagnostics Toggle',
})

-- Leap
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>l', '<Plug>(leap)', { desc = '[l] Leap current window' })
vim.keymap.set('n', '<leader>L', '<Plug>(leap-from-window)', { desc = '[L] Leap to another window' })

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
  local snacks = require 'snacks'
  snacks.notifier.notify('Formatted Buffer', 'info', { style = 'compact', timeout = 2000, title = 'Conform.nvim' })
  print 'Formatted Buffer'
end, { desc = '[f]ormat Buffer' })

vim.keymap.set('n', '<leader>F', function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  local snacks = require 'snacks'
  if vim.g.disable_autoformat then
    snacks.notifier.notify('Disabled Format-On-Save', 'info', { style = 'compact', timeout = 2000, title = 'Conform.nvim' })
    print 'Disabled Format-On-Save'
  else
    snacks.notifier.notify('Enabled Format-On-Save', 'info', { style = 'compact', timeout = 2000, title = 'Conform.nvim' })
    print 'Enabled Format-On-Save'
  end
end, { desc = 'Toggle [F]ormat-On-Save for all Buffers' })

-- scratch.nvim
vim.keymap.set('n', '<leader>|', '<cmd>Scratch<cr>', { desc = 'New Scratch Buffer' })
vim.keymap.set('n', '<leader>\\', '<cmd>ScratchOpen<cr>', { desc = 'Search Scratch Buffers' })

-- Gitsigns
-- Gitsigns Set Base
vim.keymap.set('n', '<leader>gB', function()
  Snacks.picker.git_branches {
    all = true,
    layout = 'vscode',
    format = function(item)
      return { { item.branch or item.text, 'SnacksPickerGitBranch' } }
    end,
    confirm = function(picker, item)
      picker:close()
      if not item then
        return
      end

      require('gitsigns').change_base(item.branch, true)
      Snacks.notifier.notify('Changed base to ' .. item.branch, 'info', {
        style = 'compact',
        timeout = 2000,
        title = 'Gitsigns',
      })
    end,
  }
end, { desc = 'Gitsigns Set [B]ase' })

-- Blame toggle
vim.keymap.set('n', '<leader>gb', function()
  -- close the blame split if it's open
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == 'gitsigns-blame' then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  require('gitsigns').blame()
end, { desc = 'Git [b]lame Toggle' })

-- Focus the working-tree side of a Diffview (right diff window) instead of
-- the file panel.
local function focus_diffview_working_tree(view)
  vim.schedule(function()
    view = view or require('diffview.lib').get_current_view()
    if not (view and view.cur_layout) then
      return
    end
    if view.cur_layout:is_focused() then
      return
    end

    local win = view.cur_layout:get_main_win()
    if win and vim.api.nvim_win_is_valid(win.id) then
      vim.api.nvim_set_current_win(win.id)
    end
  end)
end

-- Diffview
vim.keymap.set('n', '<leader>d', function()
  local lib = require 'diffview.lib'

  -- in a diffview tab (i.e. it's the focused tab): close it
  if lib.get_current_view() then
    vim.cmd 'DiffviewClose'
    return
  end

  -- a diffview is open in some other tab: just jump to it; it's only closed
  -- when invoked from within the diffview tab itself (above)
  for _, view in ipairs(lib.views) do
    if view.tabpage and vim.api.nvim_tabpage_is_valid(view.tabpage) then
      vim.api.nvim_set_current_tabpage(view.tabpage)
      focus_diffview_working_tree(view)
      return
    end
  end

  vim.cmd 'DiffviewOpen'

  local view = lib.get_current_view()
  if view then
    focus_diffview_working_tree(view)

    -- Re-apply after the first file loads, in case Diffview swaps layouts
    -- (for example during a merge conflict).
    view.emitter:once('file_open_post', function()
      focus_diffview_working_tree(view)
    end)
  end
end, { desc = '[D]iffview Toggle/Focus' })
