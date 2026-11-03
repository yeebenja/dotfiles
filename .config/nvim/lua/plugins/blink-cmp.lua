-- NOTE: Reference video of setting up blink.nvim
-- https://www.youtube.com/watch?v=Q0cvzaPJJas

-- Highlight group colorful-menu.nvim picked for the item's name (the first
-- highlight chunk, which always starts at offset 0). Returns nil for items
-- without an LSP semantic highlight (buffer, path, snippets, ...).
local function item_name_hl(ctx)
  local ok, colorful = pcall(require, 'colorful-menu')
  if not ok then
    return nil
  end
  local ok2, info = pcall(colorful.blink_highlights, ctx)
  if not ok2 or not info then
    return nil
  end
  for _, hl in ipairs(info.highlights or {}) do
    if hl[1] <= 0 and hl[2] > 0 then
      return hl.group
    end
  end
end

-- Unique color per completion provider. Keyed by `ctx.source_name` so every
-- LSP client (lua_ls, gopls, ...) shares the LSP color instead of using the
-- client name.
local source_hl = {
  LSP = 'Function',
  Buffer = 'Comment',
  Path = 'Directory',
  Snippets = 'String',
  Cmdline = 'Type',
}

return {
  'saghen/blink.cmp',
  event = { 'InsertEnter', 'CmdlineEnter' }, -- Load when entering insert mode or entering cmdline
  dependencies = {
    'xzbdmw/colorful-menu.nvim',
  },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      ['<C-l>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-y>'] = { 'select_and_accept', 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      -- for luasnip
      ['<C-k>'] = { 'snippet_forward', 'fallback' },
      ['<C-j>'] = { 'snippet_backward', 'fallback' },

      -- NOTE: in insert mode, <C-t> usually indents the whole block of code.
      -- by setting 'show_signature' to <C-t>, we are removing the indent
      -- functionality
      ['<C-t>'] = { 'show_signature', 'hide_signature', 'fallback' },
      -- ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
      -- ['<C-d>'] = { 'scroll_signature_down', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },

    -- automatically show documentation
    completion = {
      documentation = { auto_show = true },
      -- auto brackets
      -- NOTE: some LSPs may add auto brackets themselves anyway
      accept = { auto_brackets = { enabled = true } },
      menu = {
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'kind', gap = 1, 'source_name' } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                local highlights = require('colorful-menu').blink_components_highlight(ctx)
                -- cmdline items have no semantic highlight from colorful-menu,
                -- so tint the label to match their Property kind/icon
                if ctx.source_name == 'Cmdline' then
                  table.insert(highlights, 1, { 0, #ctx.label, group = '@property' })
                end
                return highlights
              end,
            },
            source_name = {
              text = function(ctx)
                local name = ctx.item.client_name or ctx.source_name
                return '[' .. name .. ']'
              end,
              highlight = function(ctx)
                return source_hl[ctx.source_name] or 'BlinkCmpSource'
              end,
            },
            kind = {
              highlight = function(ctx)
                return item_name_hl(ctx) or ctx.kind_hl
              end,
            },
            kind_icon = {
              highlight = function(ctx)
                -- high priority so the cursorline highlight doesn't override it
                return { { group = item_name_hl(ctx) or ctx.kind_hl, priority = 20000 } }
              end,
            },
          },
        },
      },
    }, -- disable if this gets annoying

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = 'prefer_rust' },

    -- See cmdline documentation:
    -- https://cmp.saghen.dev/modes/cmdline
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },
    signature = { enabled = true },
    -- NOTE:
    -- snippets?
    -- https://cmp.saghen.dev/configuration/snippets.html
    -- maybe make some personal snippets...

    snippets = { preset = 'luasnip' },
  },

  opts_extend = { 'sources.default' },
}
