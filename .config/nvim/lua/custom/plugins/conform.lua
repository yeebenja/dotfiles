return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
        Snacks.notifier.notify('Formatted Buffer', 'info', { style = 'compact', timeout = 2000, title = 'Conform.nvim' })
        print 'Formatted Buffer'
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>F',
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        if vim.g.disable_autoformat then
          Snacks.notifier.notify('Conform: Format-on-save disabled', 'info', { style = 'compact', timeout = 2000, title = 'Conform.nvim' })
          print 'Format-on-save disabled'
        else
          Snacks.notifier.notify('Conform: Format-on-save enabled', 'info', { style = 'compact', timeout = 2000, title = 'Conform.nvim' })
          print 'Format-on-save enabled'
        end
      end,
      mode = '',
      desc = 'Toggle [F]ormat-on-save',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Check if autoformat is disabled globally
      if vim.g.disable_autoformat then
        return
      end

      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
