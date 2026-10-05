return {
  'kevinhwang91/nvim-ufo',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    -- from YouTube
    -- require('ufo').setup {
    --   provider_selector = function(bufnr, filetype, buftype)
    --     return { 'lsp', 'indent' }
    --   end,
    --
  end,
}
