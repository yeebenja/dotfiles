return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- use latest release, remove to use latest commit
  ft = 'markdown', -- lazy load on markdown files
  cmd = 'Obsidian',
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'vault_ben',
        path = os.getenv 'HOME' .. '/Documents/vault_ben',
      },
    },
  },
  config = function(_, opts)
    require('obsidian').setup(opts)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })
  end,
}
