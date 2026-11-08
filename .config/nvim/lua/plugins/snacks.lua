local function grep_in_uncommitted_files(opts)
  opts = opts or {}
  local root = vim.fn.systemlist({ 'git', 'rev-parse', '--show-toplevel' })[1]
  if not root or root == '' then
    vim.notify('Not inside a git repo', vim.log.levels.WARN)
    return
  end

  -- tracked files with staged or unstaged changes (working tree vs HEAD)
  local files = vim.fn.systemlist { 'git', '-C', root, 'diff', '--name-only', 'HEAD' }

  -- also include new, untracked files
  vim.list_extend(files, vim.fn.systemlist { 'git', '-C', root, 'ls-files', '--others', '--exclude-standard' })

  files = vim.tbl_map(
    function(f)
      return root .. '/' .. f
    end,
    vim.tbl_filter(function(f)
      return f ~= ''
    end, files)
  )

  if #files == 0 then
    vim.notify('No changed files to grep', vim.log.levels.INFO)
    return
  end

  Snacks.picker.grep(vim.tbl_extend('force', { dirs = files }, opts))
end

-- keymap
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    image = {
      resolve = function(path, src)
        local api = require 'obsidian.api'
        if api.path_is_note(path) then
          return api.resolve_attachment_path(src)
        end
      end,
    },
    profiler = {},
    notifier = {
      enabled = true,
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
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
      top_down = true,
      date_format = '%R',
      -- format for footer when more lines are available
      -- `%d` is replaced with the number of lines.
      -- only works for styles with a border
      ---@type string|boolean
      more_format = ' ↓ %d lines ',
      refresh = 50,
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
      debug = {
        scores = false, -- show scores in the list
      },
      layout = {
        preset = 'ivy',
        -- When reaching the bottom of the results in the picker, I don't want
        -- it to cycle and go back to the top
        cycle = false,
      },
      layouts = {
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
      -- global defaults for matcher
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        -- ignorecase = true, -- use ignorecase (disabled b/c smartcase enabled)
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
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
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
  },
  keys = {
    {
      'gri',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'LSP: Go to Implementation',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sm',
      function()
        local picker = require 'snacks.picker'
        picker.marks()
      end,
      desc = '[S]earch [M]arks',
    },
    -- search lazy spec
    {
      '<leader>sl',
      function()
        Snacks.picker.lazy()
      end,
      desc = '[S]earch [L]azy Plugin Spec',
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
      desc = '[S]earch [H]elp',
    },
    -- Command History
    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Search [C]ommand History',
    },
    -- TODO comment search
    {
      '<leader>st',
      function()
        Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
      end,
      desc = 'Search TODO/FIX/FIXME',
    },
    -- Workplace Symbols
    {
      '<leader>sS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'Workplace [S]ymbols',
    },
    -- Document Symbols
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'Document [s]ymbols',
    },
    -- Goto Type Definition (via LSP)
    {
      'grt',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'LSP: Goto Type [D]efinition',
    },
    -- Goto Definition (via LSP)
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = '[G]oto [D]efinition',
    },
    -- Goto Reference (via LSP)
    {
      'grr', -- override default |vim.lsp.buf.references()| mapping
      function()
        Snacks.picker.lsp_references()
      end,
      desc = 'Goto Reference',
    },
    -- Live Grep
    {
      '<leader>sg',
      function()
        Snacks.picker.grep {
          layout = 'ivy',
          regex = true,
          format = 'file',
          show_empty = true,
          live = true, -- live grep by default
          supports_live = true,
          hidden = true, -- grep in hidden files as well
          ignored = false, -- don't grep in ignored files

          ---@field dirs? string[] directories to search
          -- ^^ from :h snacks (snacks help page)
          -- grep in cwd and scratch buffers from scratch.nvim
          dirs = {
            vim.fn.getcwd(),
            vim.fn.expand '~/.local/share/nvim-scratch',
          },
        }
      end,
      desc = '[S]earch by [G]rep',
    },
    -- Live Grep in Current File
    {
      '<leader>/',
      function()
        Snacks.picker.lines {
          layout = 'ivy',
        }
      end,
      desc = '[/] Grep in Current Buffer',
    },
    -- Grep in Open Buffers
    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers {
          layout = 'ivy',
          supports_live = true,
        }
      end,
      desc = '[/] Grep in Open Buffers',
    },
    -- Git Status
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status {
          layout = 'vertical',
        }
      end,
      desc = 'Git [S]tatus',
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
          frecency = true,
          history_bonus = true,
        }
      end,
      desc = '[S]earch [F]iles',
    },
    -- Search Keymaps
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps {
          layout = 'vertical',
        }
      end,
      desc = '[S]earch [K]eymaps',
    },

    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word {
          layout = 'ivy',
          regex = true,
          format = 'file',
          show_empty = true,
          live = true, -- live grep by default
          supports_live = true,
          hidden = true, -- grep in hidden files as well
          ignored = false, -- don't grep in ignored files

          ---@field dirs? string[] directories to search
          -- ^^ from :h snacks (snacks help page)
          -- grep in cwd and scratch buffers from scratch.nvim
          dirs = {
            vim.fn.getcwd(),
            vim.fn.expand '~/.local/share/nvim-scratch',
          },
        }
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    -- Live Grep in Specific Path
    {
      '<leader>sP',
      function()
        vim.ui.input({
          prompt = 'Grep in dir: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'dir',
        }, function(dir)
          if not dir or dir == '' then
            return
          end
          Snacks.picker.grep {
            layout = 'ivy',
            regex = true,
            format = 'file',
            show_empty = true,
            live = true,
            supports_live = true,
            hidden = true,
            dirs = { vim.fn.fnamemodify(dir, ':p') },
          }
        end)
      end,
      desc = '[S]earch Grep in [P]ath',
    },
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

          frecency = true,
          history_bonus = true,
        }
      end,
      desc = 'Buffer Picker',
    },
    -- Notification History
    {
      '<leader>sn',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Search [N]otifications',
    },
    -- Highlights
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Search [H]ighlights',
    },
    -- Grep Changed Files
    {
      '<leader>su',
      function()
        grep_in_uncommitted_files()
      end,
      desc = 'Search [U]ncommitted by Grep',
    },
  },
}
