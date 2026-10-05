return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  init = function()
    vim.g.undotree_SplitWidth = 70
    vim.g.undotree_DiffpanelHeight = 10
  end,
  config = function()
    -- Configuration for undotree
    -- view more layouts here: https://github.com/mbbill/undotree/blob/master/plugin/undotree.vim#L27
    vim.g.undotree_WindowLayout = 3
  end,
}
