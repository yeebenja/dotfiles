-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  -- version = '',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    -- { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>n', ':Neotree toggle float<CR>', desc = 'Toggle [N]eoTree Float', silent = true }, -- Open as floating
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false, -- Show hidden files
        hide_gitignored = false, -- Show .gitignored files (optional)
      },
      window = {
        -- position = 'right', -- Configuration for left window
        popup = { -- Configuration for floating window
          size = {
            height = '80%', -- Adjust height
            width = '50%', -- Adjust width
          },
          border = 'rounded', -- Add a border style
        },
        -- mappings = {
        --   ['\\'] = 'close_window',
        -- },
      },
    },
    follow_current_file = true,
    hide_dotfiles = false,
    hide_gitignore = false,
  },
}
