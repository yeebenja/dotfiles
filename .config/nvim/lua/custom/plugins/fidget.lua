return {
  'j-hui/fidget.nvim',
  event = 'LspAttach',
  config = function()
    require('fidget').setup {
      progress = {
        suppress_on_insert = true, -- suppress while typing
        ignore = { 'pyright' },    -- suppress all pyright progress notifications
      },
    }
  end,
}
