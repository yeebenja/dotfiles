-- NOTE: here is a TJ video explaining LuaSnip
-- https://www.youtube.com/watch?v=FmHhonPjvvA
return {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter', -- Load when entering insert mode
  -- follow latest release.
  version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',
  config = function()
    local ls = require 'luasnip'
    ls.config.set_config {
      -- This tells LuaSnip to remember to keep around the last snippet
      -- You can jump back into it even if you move outside of the selection
      history = true,
      -- If I have dynamic snippets, it updates as I type!
      updateevents = 'TextChanged,TextChangedI',

      -- Autosnippets:
      enable_autosnippets = true,
    }

    -- NOTE: blink-cmp handles keymaps for LuaSnip
    --
    -- expand or jump forwards
    -- expand the current item or jump to the next item within the snippet
    -- vim.keymap.set({ 'i', 's' }, '<c-k>', function()
    --   if ls.expand_or_jumpable() then
    --     ls.expand_or_jump()
    --   end
    -- end, { silent = true })

    -- jump backwards
    -- jump backwards to the prev. item within the snippet
    -- vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    --   if ls.jumpable(-1) then
    --     ls.jump(-1)
    --   end
    -- end, { silent = true })

    -- list options
    -- useful for choice nodes
    -- vim.keymap.set('i', '<c-l>', function()
    --   if ls.choice_active() then
    --     ls.change_choice(1)
    --   end
    -- end)

    -- resource snippets
    -- useful for adding/modifying/testing snippets
    -- vim.keymap.set('n', '<leader>2s', function()
    --   vim.cmd 'source ~/.config/nvim/lua/custom/plugins/luasnip.lua'
    --   print 'LuaSnip Snippets resourced'
    -- end, { desc = 'Reload LuaSnip Snippets' })

    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local extras = require 'luasnip.extras'
    local rep = extras.rep
    local fmt = require('luasnip.extras.fmt').fmt

    -- custom snippets
    ls.add_snippets('lua', { s('hello', { t "print('hello world!')" }) })
    ls.add_snippets('lua', {
      s('hello', {
        t 'print("hello ',
        i(1),
        t ' world!")',
      }),
    })
    ls.add_snippets('lua', {
      s('hello ben', {
        t 'print(Hello "',
        i(1),
        t '. Nice to meet you! Your name is ',
        rep(1),
        t '.")',
      }),
    })
    ls.add_snippets('lua', {
      s('req', {
        t 'local ',
        i(1),
        t " = require '",
        rep(1),
        t "'",
        i(0), -- (Final cursor position)
      }),
    })

    -- python
    -- var = self.var
    -- i(1) = self.rep(1)i(0)
    ls.add_snippets('python', {
      s('self.', {
        i(1),
        t ' = self.',
        rep(1),
        i(0),
      }),
    })
  end,
}
