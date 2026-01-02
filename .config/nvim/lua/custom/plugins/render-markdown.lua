return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown', -- lazy load on markdown files
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  config = function()
    local render_markdown = require 'render-markdown'
    render_markdown.setup {}
  end,
}
