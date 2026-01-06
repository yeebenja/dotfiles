-- Ben's init.lua file for Neovim
require 'vim-opts.vim-opts'
_G.global_colors = require 'globals.colors' -- _G signifies that this table is intentionally global

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'themes.themes',
  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      -- if not using nerd font: fallback on these icons
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Import keybindings
require 'keybindings.keybindings'
require 'keybindings.kickstart-keybindings'

-- load colorscheme
vim.cmd 'colorscheme eldritch'

-- Import fold
require 'nvim-ufo-config.nvim-fold-config'

-- NOTE: since leap.nvim uses IncSearch label for highlighting
-- labels, change label to bright green to make it more readable
vim.api.nvim_set_hl(0, 'IncSearch', {
  fg = global_colors.colors.eldritch_red, -- eldritch red
  bg = 'NONE', -- transparent background
  bold = true,
})

-- NOTE: original IncSearch fg and bg
-- :hi IncSearch
-- IncSearch      xxx guifg=#1a1c2c guibg=#f7c67f
vim.api.nvim_set_hl(0, 'YankHighlight', {
  fg = global_colors.colors.fg_original, -- or 'NONE;
  bg = global_colors.colors.bg_original, -- or 'NONE'
  bold = true, -- optional
})

-- import autocmds
require 'autocmds.autocmds'
-- import aliases
require 'aliases.aliases'
