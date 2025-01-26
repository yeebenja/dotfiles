local themes = {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'carbonfox'
    end,
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-storm'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'dracula'
    end,
  },
  {
    'eldritch-theme/eldritch.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      -- vim.cmd.colorscheme 'eldritch'
    end,
  },
  {
    'marko-cerovac/material.nvim',
    priority = 1000,
    init = function()
      -- vim.g.material_style = 'deep ocean' -- oceanic, deep ocean, palenight, lighter, darker
      -- vim.cmd.colorscheme 'material'
    end,
  },
  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- your optional config goes here, see below.
    end,
  },
  { 'miikanissi/modus-themes.nvim', priority = 1000 },
  { 'shaunsingh/moonlight.nvim', priority = 1000 },
  {
    'samharju/synthweave.nvim',
    priority = 1000,
  },
}
return themes
