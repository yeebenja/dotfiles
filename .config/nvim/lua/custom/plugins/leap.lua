return {
  'ggandor/leap.nvim',
  config = function()
    local leap = require 'leap'
    leap.opts.case_sensitive = false -- faster to leap when case sensitivity is False
  end,
}
