return {
  'wurli/visimatch.nvim',
  event = 'VeryLazy',
  opts = {
    -- The highlight group to apply to matched text
    hl_group = 'Search',
    -- The minimum number of selected characters required to trigger highlighting
    chars_lower_limit = 6,
    -- The maximum number of selected lines to trigger highlighting for
    lines_upper_limit = 30,
    -- By default, visimatch will highlight text even if it doesn't have exactly
    -- the same spacing as the selected region. You can set this to `true` if
    -- you're not a fan of this behaviour :)
    strict_spacing = false,
    -- Visible buffers which should be highlighted. Valid options:
    -- * `"filetype"` (the default): highlight buffers with the same filetype
    -- * `"current"`: highlight matches in the current buffer only
    -- * `"all"`: highlight matches in all visible buffers
    -- * A function. This will be passed a buffer number and should return
    --   `true`/`false` to indicate whether the buffer should be highlighted.
    buffers = 'filetype',
    -- Case-(in)nsitivity for matches. Valid options:
    -- * `true`: matches will never be case-sensitive
    -- * `false`/`{}`: matches will always be case-sensitive
    -- * a table of filetypes to use use case-insensitive matching for.
    case_insensitive = { 'markdown', 'text', 'help' },
  },
}
