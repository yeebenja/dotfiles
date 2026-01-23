-- NOTE: Reference video of setting up blink.nvim
-- https://www.youtube.com/watch?v=Q0cvzaPJJas
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

      ['<C-0>'] = { 'show_signature', 'hide_signature', 'fallback' },
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
          columns = { { 'kind_icon' }, { 'label', gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
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
    fuzzy = { implementation = 'prefer_rust_with_warning' },

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
