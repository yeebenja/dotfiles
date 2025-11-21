return {
  'ggandor/leap.nvim',
  config = function()
    local leap = require 'leap'
    leap.opts.case_sensitive = true
  end,
}
