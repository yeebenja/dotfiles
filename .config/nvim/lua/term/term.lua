local last_job_id = 0
local last_term_bufnr = 0

-- open terminal in buffer
vim.keymap.set('n', '<leader>n', function()
  vim.cmd.term()
  last_job_id = vim.bo.channel
  last_term_bufnr = vim.api.nvim_get_current_buf()
end, { desc = '[N]ew Terminal' })

-- send commands to most recent terminal
vim.keymap.set('n', '<leader>m1', function()
  vim.fn.chansend(last_job_id, { 'ls -al\r\n' })

  -- Scroll terminal to bottom
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == last_term_bufnr then
      vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(last_term_bufnr), 0 })
    end
  end
end)
