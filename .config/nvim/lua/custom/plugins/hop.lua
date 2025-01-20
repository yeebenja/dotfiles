return {
  'smoka7/hop.nvim',
  version = '*',
  config = function()
    require('hop').setup {
      keys = 'asdghklqwertyuiopzxcvbnmfj',
    }
  end,
}
