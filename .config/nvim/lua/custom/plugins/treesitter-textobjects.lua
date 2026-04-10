-- Key
-- am -> around function (outer)
-- im -> inside function (inner)
-- ac -> around class (outer)
-- ic -> inside class (inner)
-- as -> around scope
--
-- Delete
-- dam   → delete entire function (including signature)
-- dim   → delete function body only
-- dac   → delete entire class
--
-- Copy/yank:
-- yam   → yank entire function
-- yac   → yank entire class
--
-- Visual select:
-- vam   → visually select entire function
-- vim   → visually select function body
-- vas   → visually select current scope
--
-- Change:
-- cim   → change function body (delete body, enter insert mode)
-- cic   → change class body

return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    -- configuration
    require('nvim-treesitter-textobjects').setup {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          -- ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },

      move = {
        set_jumps = true,
      },
    }

    -- select
    vim.keymap.set({ 'x', 'o' }, 'am', function()
      require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
    end, { desc = 'Around function (outer)' })
    vim.keymap.set({ 'x', 'o' }, 'im', function()
      require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
    end, { desc = 'Inside function (inner)' })
    vim.keymap.set({ 'x', 'o' }, 'ac', function()
      require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
    end, { desc = 'Around class (outer)' })
    vim.keymap.set({ 'x', 'o' }, 'ic', function()
      require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
    end, { desc = 'Inside class (inner)' })
    vim.keymap.set({ 'x', 'o' }, 'as', function()
      require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')
    end, { desc = 'Around scope' })

    -- swap (niche and situational, but can be useful for functions with many parameters)
    vim.keymap.set('n', '<leader>4', function()
      require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.outer'
    end, { desc = 'Swap parameter with previous' })
    vim.keymap.set('n', '<leader>5', function()
      require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner'
    end, { desc = 'Swap parameter with next' })

    -- move
    vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
      require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
    end, { desc = 'Next function start' })
    vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
      require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
    end, { desc = 'Next class start' })
    vim.keymap.set({ 'n', 'x', 'o' }, ']o', function()
      require('nvim-treesitter-textobjects.move').goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects')
    end, { desc = 'Next loop start' })
    vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
      require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals')
    end, { desc = 'Next scope start' })
    vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
      require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds')
    end, { desc = 'Next fold start' })

    vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
      require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
    end, { desc = 'Next function end' })
    vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
      require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
    end, { desc = 'Next class end' })

    vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
      require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
    end, { desc = 'Prev function start' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
      require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
    end, { desc = 'Prev class start' })

    vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
      require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
    end, { desc = 'Prev function end' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
      require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
    end, { desc = 'Prev class end' })

    vim.keymap.set({ 'n', 'x', 'o' }, ']d', function()
      require('nvim-treesitter-textobjects.move').goto_next('@conditional.outer', 'textobjects')
    end, { desc = 'Next conditional' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[d', function()
      require('nvim-treesitter-textobjects.move').goto_previous('@conditional.outer', 'textobjects')
    end, { desc = 'Prev conditional' })

    local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next, { desc = 'Repeat last TS move (forward)' })
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous, { desc = 'Repeat last TS move (backward)' })
  end,
}
