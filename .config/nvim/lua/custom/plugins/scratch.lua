-- https://github.com/LintaoAmons/scratch.nvim
return {
  'LintaoAmons/scratch.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'folke/snacks.nvim' }, -- using snacks picker
  },
  config = function()
    local scratch = require 'scratch'
    scratch.setup {
      scratch_file_dir = vim.fn.expand '~' .. '/.local/share/nvim-scratch',
      window_cmd = 'rightbelow vsplit', -- 'vsplit' | 'split' | 'edit' | 'tabedit' | 'rightbelow vsplit'
      file_picker = 'snacks',
      filetypes = { 'md', 'txt' },
      filetype_details = { -- or, you can have more control here
        -- json = {}, -- empty table is fine
        -- ['project-name.md'] = {
        --   subdir = 'project-name', -- group scratch files under specific sub folder
        -- },
        -- ['yaml'] = {},
        -- go = {
        --   requireDir = true, -- true if each scratch file requires a new directory
        --   filename = 'main', -- the filename of the scratch file in the new directory
        --   content = { 'package main', '', 'func main() {', '  ', '}' },
        --   cursor = {
        --     location = { 4, 2 },
        --     insert_mode = true,
        --   },
        -- },
      },
      localKeys = {
        -- {
        --   filenameContains = { 'sh' },
        --   LocalKeys = {
        --     {
        --       cmd = '<CMD>RunShellCurrentLine<CR>',
        --       key = '<C-r>',
        --       modes = { 'n', 'i', 'v' },
        --     },
        --   },
        -- },
      },
      hooks = {
        -- {
        --   callback = function()
        --     vim.api.nvim_buf_set_lines(0, 0, -1, false, { 'hello', 'world' })
        --   end,
        -- },
      },
    }
  end,
}
