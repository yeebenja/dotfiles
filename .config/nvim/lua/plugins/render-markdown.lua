return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown', -- lazy load on markdown files
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  config = function()
    local render_markdown = require 'render-markdown'
    render_markdown.setup {
      heading = {},
    }

    local function set_render_markdown_highlight_group()
      local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
      print(normal.bg)
      vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = normal.bg })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = normal.bg })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = normal.bg })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = normal.bg })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = normal.bg })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = normal.bg })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = normal.bg })
    end

    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = 'vague',
      group = vim.api.nvim_create_augroup('RenderMarkdownVague', { clear = true }),
      callback = set_render_markdown_highlight_group,
    })

    if vim.g.colors_name == 'vague' then
      set_render_markdown_highlight_group()
    end
  end,
}
