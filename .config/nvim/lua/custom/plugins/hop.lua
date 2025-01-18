-- -- ~/.config/nvim/lua/plugins/treesitter.lua
-- return {
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--     config = function()
--         require("nvim-treesitter.configs").setup({
--             highlight = { enable = true },
--             indent = { enable = true },
--         })
--     end,
-- }
return {
  'smoka7/hop.nvim',
  version = '*',
  config = function()
    require('hop').setup { keys = 'asdghklqwertyuiopzxcvbnmfj' }
  end,
}
