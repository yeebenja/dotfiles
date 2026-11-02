-- aliases.lua

-- global shorthand: `:lua pick.files()` instead of `:lua Snacks.picker.files()`
-- snacks is loaded at startup (lazy = false), so this is available immediately
pcall(function()
  _G.pick = require('snacks').picker
end)

vim.cmd [[
  cnoreabbrev leet Leet
  cnoreabbrev lazy Lazy
  cnoreabbrev dvo DiffviewOpen
  cnoreabbrev dvc DiffviewClose
  cnoreabbrev mason Mason
  cnoreabbrev msg messages
  cnoreabbrev pick Pick
]]
