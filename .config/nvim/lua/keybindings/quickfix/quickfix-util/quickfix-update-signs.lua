local M = {}

-- highlight group for quickfix sign in column
vim.api.nvim_set_hl(0, 'QuickFixSign', { link = '@module.builtin' })

-- Quickfix sign definition
vim.fn.sign_define('QuickFixSign', {
  text = 'Q',
  texthl = 'QuickFixSign',
  numhl = 'QuickFixSign',
})

-- EFFECTS: Place signs for quickfix items
function M.update_qf_signs()
  -- clear existing quickfix signs
  vim.fn.sign_unplace 'qf_signs'

  -- obtain quickfix list
  local qf_list = vim.fn.getqflist()

  -- place signs for each quickfix item
  for _, item in ipairs(qf_list) do
    if item.bufnr > 0 and item.lnum > 0 then
      vim.fn.sign_place(0, 'qf_signs', 'QuickFixSign', item.bufnr, {
        lnum = item.lnum,
        priority = 10,
      })
    end
  end
end

return M
