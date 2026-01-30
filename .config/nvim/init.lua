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

-- NOTE: run :MasonToolsInstall after startup to install all
-- lsp servers

-- load colorscheme after lazy.nvim loads all plugins
vim.cmd 'colorscheme eldritch'

-- Import keybindings
require 'keybindings.vim-keybindings'
require 'keybindings.plugin-keybindings'
require 'keybindings.kickstart-keybindings'
require 'keybindings.quickfix.quickfix'

-- Import fold
require 'nvim-ufo-config.nvim-fold-config'

-- Import highlight groups
require 'highlight-groups.highlight-groups'

-- import autocmds
require 'autocmds.autocmds'

-- import aliases
require 'aliases.aliases'

-- import term
require 'term.term'

-- import user-commands
require 'user-commands.user-commands'
