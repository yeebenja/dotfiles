return {
  'luukvbaal/statuscol.nvim',
  event = 'BufReadPre',
  config = function()
    local builtin = require 'statuscol.builtin'
    require('statuscol').setup {
      -- configuration goes here, for example:
      relculright = true,
      segments = {
        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
        {
          sign = { namespace = { 'gitsigns' }, maxwidth = 1, colwidth = 1, auto = true },
          click = 'v:lua.ScSa',
        },
        {
          sign = { namespace = { 'diagnostic/signs' }, maxwidth = 2, auto = true },
          click = 'v:lua.ScSa',
        },
        { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
        {
          sign = { name = { '.*' }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          click = 'v:lua.ScSa',
        },
      },
    }
  end,
}
