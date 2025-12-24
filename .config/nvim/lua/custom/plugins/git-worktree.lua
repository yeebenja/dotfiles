return {
  'ThePrimeagen/git-worktree.nvim',
  -- depends on having telescoep plugin
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('git-worktree').setup {}
    -- load telescope extension with git_worktree
    require('telescope').load_extension 'git_worktree'
  end,
}
