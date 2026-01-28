return {
  url = 'https://codeberg.org/andyg/leap.nvim',
  config = function()
    local leap = require 'leap'
    leap.opts.case_sensitive = false -- faster to leap when case sensitivity is False

    -- store original IncSearch highlight
    local original_incsearch = nil

    -- autocommand group
    local leap_group = vim.api.nvim_create_augroup('LeapHighlightTweaks', { clear = true })

    -- autocommand for when User enters leap.nvim
    -- EFFECTS: sets IncSearch to be our own custom color
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LeapEnter',
      group = leap_group,
      callback = function()
        -- store original IncSearch highlight bejore changing it
        local hl = vim.api.nvim_get_hl(0, { name = 'IncSearch' })
        original_incsearch = hl

        -- then set custom IncSearch color
        vim.api.nvim_set_hl(0, 'IncSearch', {
          fg = global_colors.colors.eldritch_red,
          bg = 'NONE',
          bold = true,
        })
      end,
    })

    -- autocommand for when User leavers leap.nvim
    -- EFFECTS: set IncSearch back to original color
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LeapLeave',
      group = leap_group,
      callback = function()
        -- restore original IncSearch highlight
        if original_incsearch then
          vim.api.nvim_set_hl(0, 'IncSearch', original_incsearch)
        end
      end,
    })

    -- EFFECTS: sets search area as 'Comment' color
    local function set_leap_backdrop()
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    end

    set_leap_backdrop()

    -- autocommand to reapply search area highlight group whenever
    -- colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = leap_group,
      callback = set_leap_backdrop,
    })
  end,
}
