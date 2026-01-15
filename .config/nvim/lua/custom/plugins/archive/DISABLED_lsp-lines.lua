return {
  -- 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  -- config = function()
  --   require('lsp_lines').setup()
  -- end,
}

-- disabled keybindings
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
