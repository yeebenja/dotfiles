return {
  'nvim-telescope/telescope-frecency.nvim',
  -- install the latest stable version
  version = '*',
  config = function()
    require('telescope').load_extension 'frecency'
  end,
}
-- You can delete entries from DB by this command. This command does not remove the file itself, only from DB.
-- - delete the current opened file
-- - :FrecencyDelete
-- - delete the supplied path-
-- - :FrecencyDelete /full/path/to/the/file
--
--]===]
-- watch this video
-- https://www.youtube.com/watch?v=Qr-vX51gB8g
--
-- Repo
-- https://github.com/nvim-telescope/telescope-frecency.nvim
