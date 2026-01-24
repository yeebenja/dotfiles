-- EFFECTS: fetches worktree devicon symbol and current git worktree
local function git_worktree_with_icon()
  local handle = io.popen 'git rev-parse --show-toplevel 2>/dev/null'
  if not handle then
    return ''
  end
  local result = handle:read '*a'
  handle:close()
  if not result or result == '' then
    return ''
  end
  local worktree = result:gsub('\n', '')
  local name = worktree:match '[^/]+$'
  local icon = '󱁕' -- (git worktree icon)
  return string.format('%s %s', icon, name)
end

-- EFFECTS: shows if "format-on-save" is enabled/disabled
local function format_on_save_status()
  if vim.g.disable_autoformat then
    return ' NoFormat'
  end
  return ' Format'
end

-- EFFECTS: shows # of modified buffers
local function modified_buffers_count()
  local modified_buffers = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].modified and vim.api.nvim_buf_is_loaded(buf) then
      modified_buffers = modified_buffers + 1
    end
  end
  if modified_buffers == 0 then
    return ''
  end
  return string.format('● %d', modified_buffers)
end

-- EFFECTS: creates custom theme from current highlight groups
local function get_custom_theme()
  local function get_hl(name)
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    return {
      fg = hl.fg and string.format('#%06x', hl.fg) or nil,
      bg = hl.bg and string.format('#%06x', hl.bg) or nil,
      gui = hl.bold and 'bold' or hl.italic and 'italic' or nil,
    }
  end

  local normal = get_hl 'Normal'
  local statusline = get_hl 'StatusLine'
  local statusline_nc = get_hl 'StatusLineNC'
  local mode_normal = get_hl '@variable'
  local mode_insert = get_hl '@keyword'
  local mode_visual = get_hl '@keyword.function'
  local mode_replace = get_hl 'Constant'
  local mode_command = get_hl 'Function'
  local diff_add = get_hl 'DiffAdd'
  local diff_change = get_hl 'DiffChange'
  local diff_delete = get_hl 'DiffDelete'

  return {
    normal = {
      a = { fg = statusline.bg or normal.bg, bg = mode_normal.fg, gui = 'bold' },
      b = { fg = statusline.fg, bg = statusline.bg },
      c = { fg = statusline.fg, bg = statusline.bg },
    },
    insert = {
      a = { fg = statusline.bg or normal.bg, bg = mode_insert.fg, gui = 'bold' },
    },
    visual = {
      a = { fg = statusline.bg or normal.bg, bg = mode_visual.fg, gui = 'bold' },
    },
    replace = {
      a = { fg = statusline.bg or normal.bg, bg = mode_replace.fg, gui = 'bold' },
    },
    command = {
      a = { fg = statusline.bg or normal.bg, bg = mode_command.fg, gui = 'bold' },
    },
    inactive = {
      a = { fg = statusline_nc.fg, bg = statusline_nc.bg },
      b = { fg = statusline_nc.fg, bg = statusline_nc.bg },
      c = { fg = statusline_nc.fg, bg = statusline_nc.bg },
    },
  }
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- NOTE: I want this plugin to be loaded on
  -- startup because it looks cleaner
  --
  -- event = ...
  config = function()
    local function load_lualine()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = get_custom_theme(),
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
            refresh_time = 16, -- ~60fps
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            -- show current git worktree
            {
              git_worktree_with_icon,
              cond = function()
                return vim.fn.isdirectory '.git' == 1 or vim.fn.system('git rev-parse --git-dir 2>/dev/null'):find '.git' ~= nil
              end,
            },
            'diff',
            'diagnostics',
          },
          lualine_c = {
            'filename',
          },
          lualine_x = {
            {
              modified_buffers_count,
              color = { fg = global_colors.colors.modified_buffer_color },
            },
            {
              format_on_save_status,
            },
            'encoding',
            'fileformat',
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end

    load_lualine()

    -- EFFECTS: autocmd to refresh lualine when colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function()
        load_lualine()
      end,
      desc = 'Refresh lualine theme when colorscheme changes',
    })

    -- EFFECTS: refresh function globally for manual reload
    vim.api.nvim_create_user_command('LualineRefresh', function()
      load_lualine()
    end, { desc = 'Manually refresh lualine theme' })
  end,
}
