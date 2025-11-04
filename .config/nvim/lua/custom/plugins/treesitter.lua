-- Add to your plugins (using lazy.nvim)
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'html', 'lua', 'vim', 'bash' }, -- include html
      auto_install = true,
      highlight = { enable = true },
    }
  end,
}
