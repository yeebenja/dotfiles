return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('diffview').setup {
      diff_binaries = false, -- Show diffs for binaries
      enhanced_diff_hl = false, -- Use better diff highlighting
      use_icons = true, -- Requires nvim-web-devicons
      icons = { -- File status icons
        folder_closed = '',
        folder_open = '',
      },
      signs = {
        fold_closed = '',
        fold_open = '',
        done = '✓',
      },
    }
  end,
}
