return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  config = function()
    local colorizer = require 'colorizer'
    colorizer.setup()
  end,
}
