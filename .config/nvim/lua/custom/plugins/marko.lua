return {
  'mohseenrm/marko.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('marko').setup()
  end,
}
