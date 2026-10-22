vim.opt.termguicolors = true

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- show current line number on current line

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath 'state' .. '/undo'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time between when I stop typing to when Neovim triggers CursorHold event
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- keey auto format on
vim.g.disable_autoformat = false

-- turn off swap files and backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- move blocks of code up and down
vim.keymap.set({ 'v', 'x' }, 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set({ 'v', 'x' }, 'K', ":m '<-2<CR>gv=gv")

-- global statusline
vim.opt.laststatus = 3

-- rounded borders for cmd + K
vim.opt.winborder = 'rounded'

-- timeout for syntax highlighting
vim.opt.redrawtime = 3000

-- set signcolumn width
vim.opt.signcolumn = 'yes:1'

-- make diff look simpler
vim.o.diffopt = 'internal,filler,closeoff'

require('vim._core.ui2').enable {}

function _G.my_tabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr '$' do
    local buflist = vim.fn.tabpagebuflist(i)
    local bufnr = buflist[vim.fn.tabpagewinnr(i)]
    local name = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')
    if name == '' then
      name = '[No Name]'
    end
    local mod = vim.fn.getbufvar(bufnr, '&modified') == 1 and ' +' or ''
    local hl = (i == vim.fn.tabpagenr()) and '%#TabLineSel#' or '%#TabLine#'
    s = s .. hl .. '%' .. i .. 'T ' .. i .. ' ' .. name .. mod .. ' '
  end
  return s .. '%#TabLineFill#%T'
end

vim.o.tabline = '%!v:lua.my_tabline()'

-- when closing a tab page (e.g. neogit closing its own tab), focus the tab to the left
vim.opt.tabclose = 'left'
