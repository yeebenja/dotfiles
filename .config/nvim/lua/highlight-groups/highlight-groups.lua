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

  -- only tweak the completion selection for vague; other themes keep their own
  if vim.g.colors_name == 'vague' then
    -- link = false so a linked `Visual` group resolves to its real bg
    local visual_bg = vim.api.nvim_get_hl(0, { name = 'Visual', link = false }).bg or vim.api.nvim_get_hl(0, { name = 'Normal', link = false }).bg
    if visual_bg then
      vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { bg = visual_bg })
    end
  end
end

reapply_hl()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = reapply_hl,
})
