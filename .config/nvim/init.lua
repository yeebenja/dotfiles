-- init.lua
require 'vim-opts.vim-opts'

-- Global colors table
_G.global_colors = require 'globals.colors'

-- Bootstrap Lazy upon fresh startup
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
  { import = 'custom.plugins' }, -- import plugins
  { import = 'themes.themes' }, -- import themes
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

-- load colorscheme after lazy.nvim loads all plugins
vim.cmd 'colorscheme tokyonight-moon'

require 'keybindings.vim-keybindings'
require 'keybindings.plugin-keybindings'
require 'keybindings.quickfix.quickfix'
require 'nvim-ufo-config.nvim-fold-config'
require 'highlight-groups.highlight-groups'
require 'autocmds.autocmds'
require 'aliases.aliases'
require 'term.term'
require 'user-commands.user-commands'
require 'packadd.packadd'
