return {
  '3rd/image.nvim',
  ft = { 'markdown', 'norg', 'vimwiki' }, -- Only load for these file types
  event = 'VeryLazy', -- Fallback for other scenarios
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    processor = 'magick_cli',
  },
}
