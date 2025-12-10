return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- indent = { enabled = true },
    -- input = { enabled = true },
    profiler = {},
    notifier = {
      -- NOTE: https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
      -- ^^ Documentation for notifier
      enabled = true,
      timeout = 3000, -- default timeout in ms
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- editor margin to keep free. tabline and statusline are taken into account automatically
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true, -- add 1 cell of left/right padding to the notification window
      sort = { 'level', 'added' }, -- sort by level and time
      -- minimum log level to display. TRACE is the lowest
      -- all notifications are stored in history
      level = vim.log.levels.TRACE,
      icons = {
        error = ' ',
        warn = ' ',
        info = ' ',
        debug = ' ',
        trace = ' ',
      },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      ---@type snacks.notifier.style
      style = 'fancy', -- 'compact' || 'minimal' || 'fancy'
      top_down = true, -- place notifications from top to bottom
      date_format = '%R', -- time format for notifications
      -- format for footer when more lines are available
      -- `%d` is replaced with the number of lines.
      -- only works for styles with a border
      ---@type string|boolean
      more_format = ' ↓ %d lines ',
      refresh = 50, -- refresh at most every 50ms
    },
    picker = {
      -- NOTE:
      -- Follow documentation for Snacks picker here:
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
      --
      -- EXAMPLE: Everything in the picker opts is from linkarzu
      -- Here is the link: https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/snacks.lua
      --
      --
      -- My ~/github/dotfiles-latest/neovim/lazyvim/lua/config/keymaps.lua
      -- file was always showing at the top, I needed a way to decrease its
      -- score, in frecency you could use :FrecencyDelete to delete a file
      -- from the database, here you can decrease it's score
      transform = function(item)
        if not item.file then
          return item
        end
        -- Demote the "lazyvim" keymaps file:
        if item.file:match 'lazyvim/lua/config/keymaps%.lua' then
          item.score_add = (item.score_add or 0) - 30
        end
        -- Boost the "neobean" keymaps file:
        -- if item.file:match("neobean/lua/config/keymaps%.lua") then
        --   item.score_add = (item.score_add or 0) + 100
        -- end
        return item
      end,
      -- In case you want to make sure that the score manipulation above works
      -- or if you want to check the score of each file
      debug = {
        scores = false, -- show scores in the list
      },
      -- I like the "ivy" layout, so I set it as the default globaly, you can
      -- still override it in different keymaps
      layout = {
        preset = 'ivy',
        -- When reaching the bottom of the results in the picker, I don't want
        -- it to cycle and go back to the top
        cycle = false,
      },
      layouts = {
        -- I wanted to modify the ivy layout height and preview pane width,
        -- this is the only way I was able to do it
        -- NOTE: I don't think this is the right way as I'm declaring all the
        -- other values below, if you know a better way, let me know
        --
        -- Then call this layout in the keymaps above
        -- got example from here
        -- https://github.com/folke/snacks.nvim/discussions/468
        ivy = {
          layout = {
            box = 'vertical',
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.5,
            border = 'top',
            title = ' {title} {live} {flags}',
            title_pos = 'left',
            { win = 'input', height = 1, border = 'bottom' },
            {
              box = 'horizontal',
              { win = 'list', border = 'none' },
              { win = 'preview', title = '{preview}', width = 0.5, border = 'left' },
            },
          },
        },
        -- I wanted to modify the layout width
        --
        vertical = {
          layout = {
            backdrop = false,
            width = 0.8,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = 'vertical',
            border = 'rounded',
            title = '{title} {live} {flags}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            { win = 'list', border = 'none' },
            { win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
          },
        },
      },
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        -- the bonusses below, possibly require string concatenation and path normalization,
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = false, -- give bonus for matching files in the cwd
        frecency = true, -- frecency bonus
        history_bonus = true, -- give more weight to chronological order
      },
      sort = {
        -- default sort is by score, text length and index
        fields = { 'score:desc', '#text', 'idx' },
      },
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            -- I'm used to scrolling like this in LazyGit
            ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
            ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
          },
        },
      },
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 80,
        },
      },
    },
    -- quickfile = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
    -- terminal = { enabled = true },
    ---@class snacks.picker.grep.Config: snacks.picker.proc.Config
    ---@field cmd? string
    ---@field hidden? boolean show hidden files
    ---@field ignored? boolean show ignored files
    ---@field dirs? string[] directories to search
    ---@field follow? boolean follow symlinks
    ---@field glob? string|string[] glob file pattern(s)
    ---@field ft? string|string[] ripgrep file type(s). See `rg --type-list`
    ---@field regex? boolean use regex search pattern (defaults to `true`)
    ---@field buffers? boolean search in open buffers
    ---@field need_search? boolean require a search pattern
    ---@field exclude? string[] exclude patterns
    ---@field args? string[] additional arguments
    ---@field rtp? boolean search in runtimepath
    --- NOTE: ? means that the fiield is optional in the configuration table
    --- so, hidden? means that hidden is an optional field
    grep = {
      finder = 'grep',
      regex = true,
      format = 'file',
      show_empty = true,
      live = true, -- live grep by default
      supports_live = true,
      hidden = true, -- grep in hidden files as well
      ignored = false, -- don't grep in ignored files
    },
  },
  keys = {
    -- TODO: split join all of these plugins

    -- search lazy spec
    {
      '<leader>sl',
      function()
        Snacks.picker.lazy()
      end,
      desc = '[S]earch [L]azy Plugin Spec (Snacks)',
    },
    -- search themes
    {
      '<leader>at',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = '[T]hemes',
    },
    -- search help
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp (Snacks)',
    },
    -- LATER: figure out of neovim profiling works
    -- Snacks profiler
    {
      '<leader>pp',
      function()
        Snacks.toggle.profiler()
      end,
      desc = 'Toggle Profiler',
    },
    {
      '<leader>ph',
      function()
        Snacks.toggle.profiler_highlights()
      end,
      desc = 'Toggle Profiler Highlights',
    },
    -- Your existing scratch buffer keymap
    {
      '<leader>ps',
      function()
        Snacks.profiler.scratch()
      end,
      desc = 'Profiler Scratch Buffer',
    },
    -- TODO comment search
    {
      '<leader>st',
      function()
        Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
      end,
      desc = 'Search TODO/FIX/FIXME (Snacks)',
    },
    -- Workplace Symbols
    {
      '<leader>ws',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = '[W]orkplace [S]ymbols (Snacks)',
    },
    -- Document Symbols
    {
      '<leader>ds',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = '[D]ocument [S]ymbols (Snacks)',
    },
    -- Goto Type Definition (via LSP)
    {
      '<leader>D',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = '[G]oto Type [D]efinition (Snacks)',
    },
    -- Goto Definition (via LSP)
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = '[G]oto [D]efinition (Snacks)',
    },
    -- Goto Reference (via LSP)
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      desc = '[G]oto [R]eference (Snacks)',
    },
    -- Live Grep
    {
      '<leader>sg',
      function()
        Snacks.picker.grep {
          layout = 'ivy',
        }
      end,
      desc = '[S]earch by [G]rep (Snacks)',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.lines {
          layout = 'vscode',
        }
      end,
      desc = '[/] Grep in Current Buffer (Snacks)',
    },
    -- Git Log
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log {
          finder = 'git_log',
          format = 'git_log',
          preview = 'git_show',
          confirm = 'git_checkout',
          layout = 'vertical',
        }
      end,
      desc = 'Git [L]og (Snacks)',
    },
    -- Git Branches
    {
      '<leader>gc',
      function()
        Snacks.picker.git_branches {
          layout = 'select',
        }
      end,
      desc = '[C]heckout Branches (Snacks)',
    },
    -- Git Status
    {
      '<leader>gt',
      function()
        Snacks.picker.git_status {
          layout = 'vertical',
        }
      end,
      desc = 'Git S[T]atus (Snacks)',
    },
    -- Search Files
    {
      '<leader>sf',
      function()
        Snacks.picker.files {
          finder = 'files',
          format = 'file',
          show_empty = true,
          supports_live = true,
          layout = 'ivy',
          ignored = true, -- ignore ignored files
          hidden = true, -- include hidden files when searching
        }
      end,
      desc = '[S]earch [F]iles (Snacks)',
    },
    -- Search Keymaps
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps {
          layout = 'vertical',
        }
      end,
      desc = '[S]earch [K]eymaps (Snacks)',
    },
    -- Buffer Picker
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers {
          -- I always want my buffers picker to start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
          finder = 'buffers',
          format = 'buffer',
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ['d'] = 'bufdelete',
              },
            },
            list = { keys = { ['d'] = 'bufdelete' } },
          },
          -- In case you want to override the layout for this keymap
          -- layout = "ivy",
        }
      end,
      desc = 'Buffer Picker',
    },
  },
}
