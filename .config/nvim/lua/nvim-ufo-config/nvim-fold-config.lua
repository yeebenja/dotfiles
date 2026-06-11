vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

local ftMap = {
  vim = 'indent',
  python = { 'indent' },
  git = '',
  typescript = { 'treesitter', 'indent' }, -- TS
  typescriptreact = { 'treesitter', 'indent' }, -- TSX
}
require('ufo').setup {

  fold_virt_text_handler = handler,
  open_fold_hl_timeout = 150,
  close_fold_kinds_for_ft = {
    default = { 'imports', 'comment' },
    json = { 'array' },
    c = { 'comment', 'region' },
  },
  close_fold_current_line_for_ft = {
    default = true,
    c = false,
  },
  preview = {
    win_config = {
      border = { '', '─', '', '', '', '─', '', '' },
      winhighlight = 'Normal:Folded',
      winblend = 0,
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>',
      jumpTop = '[',
      jumpBot = ']',
    },
  },
  provider_selector = function(bufnr, filetype, buftype)
    -- if you prefer treesitter provider rather than lsp,
    -- return ftMap[filetype] or {'treesitter', 'indent'}
    return ftMap[filetype]

    -- refer to ./doc/example.lua for detail
  end,
}
-- keymaps for ufo
vim.keymap.set('n', 'zR', function() require('ufo').openAllFolds() end, { desc = 'UFO: Open all folds' })
vim.keymap.set('n', 'zM', function() require('ufo').closeAllFolds() end, { desc = 'UFO: Close all folds' })
vim.keymap.set('n', 'zr', function() require('ufo').openFoldsExceptKinds() end)
vim.keymap.set('n', 'zm', function() require('ufo').closeFoldsWith() end) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'zK', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = 'UFO: Peek Fold' })

-- custom symbols for column status line
vim.opt.fillchars = {
  foldopen = '▼',
  foldclose = '▶',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
