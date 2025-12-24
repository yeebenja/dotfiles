return {
  'isakbm/gitgraph.nvim',
  opts = {
    git_cmd = 'git',
    -- NOTE: using kitty specific symbols for gitgraph
    symbols = {
      merge_commit = '',
      commit = '',
      merge_commit_end = '',
      commit_end = '',

      -- Advanced symbols
      GVER = '',
      GHOR = '',
      GCLD = '',
      GCRD = '╭',
      GCLU = '',
      GCRU = '',
      GLRU = '',
      GLRD = '',
      GLUD = '',
      GRUD = '',
      GFORKU = '',
      GFORKD = '',
      GRUDCD = '',
      GRUDCU = '',
      GLUDCD = '',
      GLUDCU = '',
      GLRDCL = '',
      GLRDCR = '',
      GLRUCL = '',
      GLRUCR = '',
    },
    format = {
      timestamp = '%H:%M:%S %d-%m-%Y',
      fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
    },
    hooks = {
      on_select_commit = function(commit)
        print('selected commit:', commit.hash)
      end,
      on_select_range_commit = function(from, to)
        print('selected range:', from.hash, to.hash)
      end,
    },
  },
  config = function(_, opts)
    require('gitgraph').setup(opts)

    -- Link to common colorscheme highlight groups
    vim.api.nvim_set_hl(0, 'GitGraphBranch1', { link = 'DiagnosticError' }) -- or 'ErrorMsg', 'DiffDelete'
    vim.api.nvim_set_hl(0, 'GitGraphBranch2', { link = 'DiagnosticOk' }) -- or 'String', 'DiffAdd'
    vim.api.nvim_set_hl(0, 'GitGraphBranch3', { link = 'DiagnosticInfo' }) -- or 'Function', 'Type'
    vim.api.nvim_set_hl(0, 'GitGraphBranch4', { link = 'DiagnosticHint' }) -- or 'Keyword', 'Constant'
    vim.api.nvim_set_hl(0, 'GitGraphBranch5', { link = 'DiagnosticWarn' }) -- or 'WarningMsg', 'DiffChange'
    -- Text element colors
    vim.api.nvim_set_hl(0, 'GitGraphHash', { link = 'Comment' }) -- or 'Identifier', 'Special'
    vim.api.nvim_set_hl(0, 'GitGraphTimestamp', { link = 'Comment' }) -- or 'Number', 'NonText'
    vim.api.nvim_set_hl(0, 'GitGraphAuthor', { link = 'String' }) -- or 'Identifier', 'Function'
    vim.api.nvim_set_hl(0, 'GitGraphBranchName', { link = 'Keyword' }) -- or 'Function', 'Type'
    vim.api.nvim_set_hl(0, 'GitGraphBranchTag', { link = 'Tag' }) -- or 'Constant', 'Special'
    vim.api.nvim_set_hl(0, 'GitGraphBranchMsg', { link = 'Normal' }) -- or 'String', 'Title'
  end,
  keys = {
    {
      '<leader>gl',
      function()
        require('gitgraph').draw({}, { all = true, max_count = 5000 })
      end,
      desc = 'Git [L]og Graph',
    },
  },
}
