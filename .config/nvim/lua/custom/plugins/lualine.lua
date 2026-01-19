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

return {

  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- NOTE: I want this plugin to be loaded on
  -- startup because it looks cleaner
  --
  -- event = ...
  opts = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
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
        -- -- date time
        -- {
        --   function()
        --     return os.date '%H:%M:%S %a %m/%d/%Y'
        --   end,
        -- }, -- 14:30 12/24/2024
        -- Git worktree
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
  },
}
