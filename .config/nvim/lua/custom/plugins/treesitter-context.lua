-- NOTE: Look at this later. I need to figure out how config function works

return {
  'nvim-treesitter/nvim-treesitter-context',
  opts = {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    multiwindow = false, -- Enable multiwindow support.
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  },
  config = function(_, opts)
    -- Set up the plugin with the provided options
    require('treesitter-context').setup(opts)
    -- Automatically toggle Treesitter Context on plugin load
    require('treesitter-context').toggle()
  end,
  keys = {
    {
      '<leader>ac',
      function()
        -- Snacks.notify.notify('Treesitter Context Toggled', 'info', { style = 'fancy' })
        Snacks.notifier.notify('Treesitter Context Toggled', 'info', { style = 'fancy', timeout = 3000, title = 'Snacks Notifier' })
        vim.cmd 'TSContextToggle' -- Then toggle it
      end,
      desc = 'Treesitter [C]ontext Toggle',
    },
  },
}
