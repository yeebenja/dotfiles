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

return {

  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
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
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
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
