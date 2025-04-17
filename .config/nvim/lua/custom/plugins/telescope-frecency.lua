return {
  'nvim-telescope/telescope-frecency.nvim',
  -- install the latest stable version
  version = '*',
  config = function()
    require('telescope').load_extension 'frecency'
  end,
}

-- watch this video
-- https://www.youtube.com/watch?v=Qr-vX51gB8g
--
-- Repo
-- https://github.com/nvim-telescope/telescope-frecency.nvim
