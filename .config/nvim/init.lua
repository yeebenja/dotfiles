-- Ben's init.lua file for Neovim
_G.global_colors = require 'globals.colors' -- _G signifies that this table is intentionally global

require 'vim-opts.vim-opts'

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

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- Load themes
  -- unpack(require 'themes.themes'),
  require 'themes.themes',
  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  -- LSP Plugins
  { import = 'custom.plugins' },
  -- NOTE: Here are custom keymaps for my plugins:
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
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

-- JavaScript and TypeScript-specific indentation settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- import autocmds
require 'autocmds.autocmds'
-- import aliases
require 'aliases.aliases'
