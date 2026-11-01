-- highlight-groups.lua

-- NOTE: original IncSearch fg and bg
-- :hi IncSearch
-- IncSearch      xxx guifg=#1a1c2c guibg=#f7c67f

local function reapply_hl()
  vim.api.nvim_set_hl(0, 'YankHighlight', {
    fg = global_colors.colors.fg_yank_highlight,
    bg = global_colors.colors.bg_yank_highlight,
    bold = true,
  })

  vim.api.nvim_set_hl(0, 'MiniJump', { fg = global_colors.colors.fg_mini_jump, bold = true })
end

reapply_hl()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = reapply_hl,
})
