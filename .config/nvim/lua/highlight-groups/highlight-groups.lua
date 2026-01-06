-- highlight-groups.lua
-- NOTE: since leap.nvim uses IncSearch label for highlighting
-- labels, change label to bright green to make it more readable
vim.api.nvim_set_hl(0, 'IncSearch', {
  fg = global_colors.colors.eldritch_red, -- eldritch red
  bg = 'NONE', -- transparent background
  bold = true,
})

-- NOTE: original IncSearch fg and bg
-- :hi IncSearch
-- IncSearch      xxx guifg=#1a1c2c guibg=#f7c67f
vim.api.nvim_set_hl(0, 'YankHighlight', {
  fg = global_colors.colors.fg_original, -- or 'NONE;
  bg = global_colors.colors.bg_original, -- or 'NONE'
  bold = true, -- optional
})
