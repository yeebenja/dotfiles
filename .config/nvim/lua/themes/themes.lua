local themes = {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
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
    lazy = true,
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
    lazy = true,
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  {
    'Mofiqul/dracula.nvim',
    lazy = true,
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'dracula'
    end,
  },
  {
    'eldritch-theme/eldritch.nvim',
    lazy = true,
    priority = 1000,
    -- NOTE: use this specific version of eldritch if i want the original
    -- status bar theme
    -- commit = 'cddd745d4bd317a5c142708def49fd466fd87fc6',
    opts = {},
    init = function()
      -- vim.cmd.colorscheme 'eldritch'
    end,
  },
  {
    'marko-cerovac/material.nvim',
    lazy = true,
    priority = 1000,
    init = function()
      -- vim.g.material_style = 'deep ocean' -- oceanic, deep ocean, palenight, lighter, darker
      -- vim.cmd.colorscheme 'material'
    end,
  },
  {
    'uloco/bluloco.nvim',
    lazy = true,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- your optional config goes here, see below.
    end,
  },
  {
    'miikanissi/modus-themes.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'shaunsingh/moonlight.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'samharju/synthweave.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    '0xstepit/flow.nvim',
    lazy = true,
    priority = 1000,
    tag = 'v2.0.1',
    opts = {
      theme = {
        style = 'dark', --  "dark" | "light"
        contrast = 'default', -- "default" | "high"
        transparent = false, -- true | false
      },
      colors = {
        mode = 'default', -- "default" | "dark" | "light"
        fluo = 'pink', -- "pink" | "cyan" | "yellow" | "orange" | "green"
        custom = {
          saturation = '', -- "" | string representing an integer between 0 and 100
          light = '', -- "" | string representing an integer between 0 and 100
        },
      },
      ui = {
        borders = 'inverse', -- "theme" | "inverse" | "fluo" | "none"
        aggressive_spell = false, -- true | false
      },
    },
    config = function(_, opts)
      require('flow').setup(opts)
      -- vim.cmd("colorscheme flow")
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    config = function()
      require('rose-pine').setup {
        variant = 'auto', -- auto, main, moon, or dawn
        dark_variant = 'main', -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },

        groups = {
          border = 'muted',
          link = 'iris',
          panel = 'surface',

          error = 'love',
          hint = 'iris',
          info = 'foam',
          note = 'pine',
          todo = 'rose',
          warn = 'gold',

          git_add = 'foam',
          git_change = 'rose',
          git_delete = 'love',
          git_dirty = 'rose',
          git_ignore = 'muted',
          git_merge = 'iris',
          git_rename = 'pine',
          git_stage = 'iris',
          git_text = 'rose',
          git_untracked = 'subtle',

          h1 = 'iris',
          h2 = 'foam',
          h3 = 'rose',
          h4 = 'gold',
          h5 = 'pine',
          h6 = 'foam',
        },

        palette = {
          -- Override the builtin palette per variant
          -- moon = {
          --     base = '#18191a',
          --     overlay = '#363738',
          -- },
        },

        highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
        },

        before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          -- if highlight.undercurl then
          --     highlight.undercurl = false
          -- end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --     highlight.fg = palette.foam
          -- end
        end,
      }
    end,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
      }
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        -- your options here
      }
    end,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = true,
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
  },
  {
    'nxvu699134/vn-night.nvim',
    lazy = true,
  },
  {
    'vague-theme/vague.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      require('vague').setup {
        -- optional config
      }
    end,
  },
}
return themes
