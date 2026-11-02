vim.api.nvim_create_user_command('Checklsp', function()
  vim.cmd 'checkhealth vim.lsp'
end, { desc = 'Check LSP status' })
vim.cmd 'cnoreabbrev checklsp Checklsp'

-- show :messages in a buffer
vim.api.nvim_create_user_command('Messages', function()
  vim.cmd 'enew'
  vim.api.nvim_put(vim.split(vim.fn.execute 'messages', '\n'), 'l', true, false)
  vim.bo.buftype = 'nofile'
end, { desc = 'Load Messages in Buffer' })

-- Picker command with completion for Snacks.picker
local picker_internal = {
  get = true,
  health = true,
  pick = true,
  select = true,
  setup = true,
}

---@return string[]
local function picker_names()
  local ok, Snacks = pcall(require, 'snacks')
  if not ok or not Snacks.picker then
    return {}
  end

  local names = {}

  -- All built-in source names (files, grep, buffers, ...)
  local sources = Snacks.picker.sources
  if type(sources) == 'table' then
    for name in pairs(sources) do
      names[name] = true
    end
  end

  -- Public picker methods (pickers, resume, notifications, ...)
  for name, value in pairs(Snacks.picker) do
    if type(value) == 'function' and not name:match '^_' and not picker_internal[name] then
      names[name] = true
    end
  end

  return vim.tbl_keys(names)
end

vim.api.nvim_create_user_command('Pick', function(opts)
  local ok, Snacks = pcall(require, 'snacks')
  if not ok then
    vim.notify('Snacks is not available', vim.log.levels.ERROR)
    return
  end

  local name = vim.trim(opts.args)
  if name == '' then
    return Snacks.picker 'pickers'
  end

  local fn = Snacks.picker[name]
  if type(fn) == 'function' then
    return fn()
  end

  Snacks.picker(name)
end, {
  nargs = '?',
  desc = 'Open a Snacks picker (no args lists all pickers)',
  complete = function(arglead)
    local names = picker_names()
    table.sort(names)
    if arglead == '' then
      return names
    end
    local lead = arglead:lower()
    return vim.tbl_filter(function(name)
      return name:lower():find(lead, 1, true) ~= nil
    end, names)
  end,
})
