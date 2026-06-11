-- Add to your plugins (using lazy.nvim)
return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  branch = 'main',
  config = function()
    -- NOTE: use TSClean to uninstall all parsers
    vim.api.nvim_create_user_command('TSClean', function()
      vim.cmd 'TSUninstall all'
    end, {})

    local treesitter = require 'nvim-treesitter'
    treesitter.setup {}

    local ensure_installed = {
      'c',
      'cpp',
      'java',
      'python',
      'bash',
      'html',
      'css',
      'scss',
      'javascript',
      'typescript',
      'tsx',
      'json',
      'sql',
      'query',
      'diff',
      'lua',
      'luadoc',
      'vim',
      'vimdoc',
      'markdown',
      'markdown_inline',
    }

    local config = require 'nvim-treesitter.config'

    local already_installed = config.get_installed()
    local parsers_to_install = {}

    for _, parser in ipairs(ensure_installed) do
      if not vim.tbl_contains(already_installed, parser) then
        table.insert(parsers_to_install, parser)
      end
    end

    if #parsers_to_install > 0 then
      treesitter.install(parsers_to_install)
    end

    local group = vim.api.nvim_create_augroup('TreeSitterConfig', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      callback = function(args)
        if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
          vim.treesitter.start(args.buf)
        end
      end,
    })
  end,
}
