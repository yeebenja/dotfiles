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
vim.keymap.set('n', '<leader>V', '<cmd>bot vert sf #<CR>', { desc = 'Split Alternate Buffer' })

-- Resize buffers
vim.keymap.set('n', '<M-]>', ':vertical resize +5<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<M-[>', ':vertical resize -5<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<M-}>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<M-{>', ':resize -2<CR>', { desc = 'Decrease window height' })

-- date time
vim.keymap.set('n', '<leader>dt', function()
  local date = os.date '%Y-%m-%d %H:%M:%S'
  vim.api.nvim_put({ tostring(date) }, 'c', true, true)
end, { desc = '[D]ate/[T]ime Insert' })

-- Toggle wrapping text
vim.keymap.set('n', '<leader>aw', '<cmd>set wrap!<CR>', { desc = '[W]rap Text Toggle' })

-- Toggle relative line numbers
vim.keymap.set('n', '<leader>r', function()
  local enable_relative_numbers = not vim.wo.relativenumber
  vim.opt.relativenumber = enable_relative_numbers

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == '' then
      vim.api.nvim_set_option_value('relativenumber', enable_relative_numbers, { win = win })
    end
  end
end, { desc = 'Toggle Relative Line Numbers' })

-- toggle lsp
vim.keymap.set('n', '<leader>al', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  if #clients > 0 then
    for _, client in ipairs(clients) do
      client:stop()
    end
  else
    vim.api.nvim_exec_autocmds('FileType', { buf = bufnr })
  end
end, { desc = '[L]SP Toggle' })

-- Clear highlights on search
vim.keymap.set('n', '<Esc>', '<cmd>noh<CR>')

-- Exit terminal mode
-- NOTE: might not work in all terminals/tmux
-- Use default keybind <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
