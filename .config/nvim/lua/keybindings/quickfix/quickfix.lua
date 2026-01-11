-- quickfix.lua
-- Quickfix specific keybindings

-- Quickfix prev
vim.keymap.set('n', '<M-k>', function()
  pcall(function() -- NOTE: pcall function catches errors and silently ignores them
    vim.cmd 'cprev'
  end)
end, { silent = true, desc = 'Quickfix Prev' })

-- Quickfix next
vim.keymap.set('n', '<M-j>', function()
  pcall(function()
    vim.cmd 'cnext'
  end)
end, { silent = true, desc = 'Quickfix Next' })

-- Add file to Quickfix list
vim.keymap.set('n', '<M-q>', function()
  vim.fn.setqflist(
    {
      {
        filename = vim.fn.expand '%',
        lnum = vim.fn.line '.',
        col = vim.fn.col '.',
        text = vim.fn.getline '.',
      },
    },
    'a' -- 'a' flag appends to quickfix list instead of replacing it
  )
  -- update qf signs after adding item
  require('keybindings.quickfix.quickfix-util.quickfix-update-signs').update_qf_signs()
  local notifier = require 'snacks.notifier'
  notifier.notify('Added Position to Quickfix List', 'info', { style = 'fancy', timeout = 2000, title = 'Quickfix' })
end, { desc = 'Add Current Position to Quickfix List' })

-- Toggle Quickfix list
vim.keymap.set('n', '<C-q>', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_exists = true
      break
    end
  end

  if qf_exists then
    vim.cmd 'cclose'
  else
    vim.cmd 'copen'
  end
end, { silent = true, desc = 'Toggle Quickfix' })

-- Allow list item deletion in Quickfix Buffer
-- dd (delete selected item)
-- dD (delete all items)
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('qf', { clear = true }),
  callback = function()
    if vim.bo.buftype == 'quickfix' then
      -- delete one item
      vim.keymap.set('n', 'dd', function()
        local idx = vim.fn.line '.'
        local qflist = vim.fn.getqflist()
        table.remove(qflist, idx)
        vim.fn.setqflist(qflist, 'r')
      end, { buffer = true })
      -- Clear entire quickfix list
      vim.keymap.set('n', 'dD', function()
        vim.fn.setqflist {}
      end, { buffer = true, desc = 'Clear Quickfix List' })
      -- update qf signs after deleting
      require('keybindings.quickfix.quickfix-util.quickfix-update-signs').update_qf_signs()
    end
  end,
})
