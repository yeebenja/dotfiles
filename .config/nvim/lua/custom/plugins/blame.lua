return {
  'FabijanZulj/blame.nvim',
  cmd = 'BlameToggle',
  config = function()
    require('blame').setup {
      date_format = '%m.%d.%Y',
    }
  end,
}
