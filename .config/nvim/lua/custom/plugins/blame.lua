return {
  {
    'FabijanZulj/blame.nvim',
    lazy = false,
    config = function()
      require('blame').setup {
        date_format = '%m.%d.%Y',
      }
    end,
  },
}
