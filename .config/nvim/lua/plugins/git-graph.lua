return {
  'isakbm/gitgraph.nvim',
  dependencies = { 'echasnovski/mini.nvim', 'arnamak/stay-centered.nvim' },
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
      timestamp = '%m-%d-%Y %H:%M:%S',
      fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
    },
    hooks = {
      -- Check diff of a commit
      on_select_commit = function(commit)
        vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
        vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
      end,
      -- Check diff from commit a -> commit b
      on_select_range_commit = function(from, to)
        vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
        vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
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

    local augroup = vim.api.nvim_create_augroup('GitGraphRelNumber', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'gitgraph',
      group = augroup,
      callback = function()
        vim.schedule(function()
          vim.wo.relativenumber = true
          vim.wo.number = true
        end)
      end,
    })
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
