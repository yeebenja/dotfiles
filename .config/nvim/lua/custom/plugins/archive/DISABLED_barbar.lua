return {
  -- {
  --   'romgrk/barbar.nvim',
  --   dependencies = {
  --     'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
  --     'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  --   },
  --   init = function()
  --     vim.g.barbar_auto_setup = false
  --   end,
  --   opts = {
  --     -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
  --     animation = true,
  --     clickable = true,
  --     insert_at_start = true,
  --     -- …etc.
  --   },
  --   version = '^1.0.0', -- optional: only update when a new 1.x version is released
  -- },
}

-- disabled keybindings
-- Barbar DISABLED
-- NOTE: <C-7> and <C-0> don't work with TMUX
-- vim.keymap.set('n', '<C-7>', function()
--   vim.cmd ':BufferPrevious'
-- end, { desc = 'Buffer Move Previous' })
-- vim.keymap.set('n', '<C-0>', function()
--   vim.cmd ':BufferNext'
-- end, { desc = 'Buffer Move Next' })
