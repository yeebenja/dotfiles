return {
  'akinsho/git-conflict.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '*',
  config = function()
    require('git-conflict').setup {
      default_mappings = true,
      default_commands = true,
      disable_diagnostics = false,
      list_opener = 'copen',
      highlights = {
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
    }
  end,
}
