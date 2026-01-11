local last_job_id = 0
local last_term_bufnr = 0

-- open terminal in buffer
vim.keymap.set('n', '<leader>N', function()
  vim.cmd.term()
  last_job_id = vim.bo.channel
  last_term_bufnr = vim.api.nvim_get_current_buf()
end, { desc = '[N]ew Terminal' })

-- EFFECTS: Scrolls terminal buffer to bottom
local scroll_to_bottom = function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == last_term_bufnr then
      vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(last_term_bufnr), 0 })
    end
  end
end

-- ls -a
vim.keymap.set('n', '<leader>ml', function()
  vim.fn.chansend(last_job_id, { 'ls -a\r\n' })
  vim.schedule(scroll_to_bottom)
end, { desc = 'ls -a' })

-- git status
vim.keymap.set('n', '<leader>mg', function()
  vim.fn.chansend(last_job_id, { 'git status\r\n' })
  vim.schedule(scroll_to_bottom)
end, { desc = 'git status' })
