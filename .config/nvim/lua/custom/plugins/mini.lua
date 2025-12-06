return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }
    require('mini.bufremove').setup {}

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    -- local statusline = require 'mini.statusline'
    -- -- set use_icons to true if you have a Nerd Font
    -- statusline.setup { use_icons = vim.g.have_nerd_font }
    --
    -- -- You can configure sections in the statusline by overriding their
    -- -- default behavior. For example, here we set the section for
    -- -- cursor location to LINE:COLUMN
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return '%2l:%-2v'
    -- end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
    -- NOTE: Here are my custom plugins for mini.nvim
    require('mini.indentscope').setup()
    -- require('mini.animate').setup() -- Made me motion sick :|
    -- require('mini.basics').setup()
    -- require('mini.files').setup() -- Already have neo-tree
    require('mini.surround').setup()
    -- require('mini.notify').setup()
    require('mini.jump').setup {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        forward = 'f',
        backward = 'F',
        forward_till = 't',
        backward_till = 'T',
        repeat_jump = ';',
      },

      -- Delay values (in ms) for different functionalities. Set any of them to
      -- a very big number (like 10^7) to virtually disable.
      delay = {
        -- Delay between jump and highlighting all possible jumps
        highlight = 0, -- (0 = no delay)

        -- Delay between jump and automatic stop if idle (no jump is done)
        idle_stop = 10000000,
      },

      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    }
    require('mini.splitjoin').setup {}
    -- NOTE: Keybindings for MiniSplitjoin.toggle() is gS
  end,
}
