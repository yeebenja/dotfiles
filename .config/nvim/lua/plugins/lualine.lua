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

-- returns exactly what lualine uses for theme = 'auto'
local function get_auto_theme()
  local ok, theme = pcall(require('lualine.utils.loader').load_theme, 'auto')
  return ok and theme or nil
end

local function get_custom_theme()
  local theme = get_auto_theme() or {}

  local function get_hl(name)
    local hl = vim.api.nvim_get_hl(0, { name = name })
    return {
      fg = hl.fg and string.format('#%06x', hl.fg) or nil,
      bg = hl.bg and string.format('#%06x', hl.bg) or nil,
      gui = hl.bold and 'bold' or hl.italic and 'italic' or nil,
    }
  end

  local normal = get_hl 'Normal'
  local statusline_nc = get_hl 'StatusLineNC'

  -- merge only the pieces you want to change; everything else
  -- (including auto's mode colors) is inherited
  theme.normal = vim.tbl_deep_extend('force', theme.normal or {}, {
    a = { fg = normal.bg, bg = get_hl('@variable').fg, gui = 'bold' },
  })

  -- lualine_b (branch/diff/diagnostics) and lualine_y (progress) use the `b`
  -- colors: keep their background equal to the middle section (c) and their
  -- text equal to the NORMAL mode indicator's background
  local normal_a = theme.normal.a or {}
  local normal_b = theme.normal.b or {}
  local normal_c = theme.normal.c or {}
  for _, mode in ipairs { 'normal', 'insert', 'visual', 'replace', 'command', 'terminal' } do
    local section = theme[mode]
    if section then
      if section.a then
        section.a.gui = 'bold'
      end
      section.b = { fg = normal_a.bg, bg = normal_c.bg or normal_b.bg }
    end
  end

  theme.inactive = {
    a = { fg = statusline_nc.fg, bg = statusline_nc.bg },
    b = { fg = statusline_nc.fg, bg = statusline_nc.bg },
    c = { fg = statusline_nc.fg, bg = statusline_nc.bg },
  }

  return theme
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
          globalstatus = true,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
            refresh_time = 32, -- ~30fps
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            -- NOTE: hide current git worktree b/c it causes cursor flickering
            -- {
            --   git_worktree_with_icon,
            --   cond = function()
            --     return vim.fn.isdirectory '.git' == 1 or vim.fn.system('git rev-parse --git-dir 2>/dev/null'):find '.git' ~= nil
            --   end,
            -- },
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
