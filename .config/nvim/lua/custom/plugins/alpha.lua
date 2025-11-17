return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local startify = require 'alpha.themes.startify'

    -- Get Neovim version
    local version = vim.version()
    local nvim_version = string.format('NVIM v%d.%d.%d', version.major, version.minor, version.patch)
    local version_short = string.format('v%d.%d', version.major, version.minor)

    -- Custom header with version and tips
    startify.section.header.val = {
      '',
      '',
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
      '',
      nvim_version,
      '',
      'Nvim is open source and freely distributable',
      'https://neovim.io/#chat',
      '',
      'type  :help nvim<Enter>         if you are new!',
      'type  :checkhealth<Enter>       to optimize Nvim',
      'type  :q<Enter>                 to exit',
      'type  :help<Enter>              for help',
      '',
      'type  :help news<Enter> to see changes in ' .. version_short,
      '',
    }

    -- Center all sections by modifying the layout
    for _, section in pairs(startify.section) do
      if type(section) == 'table' and section.val then
        section.opts = section.opts or {}
        section.opts.position = 'center'
      end
    end

    -- Set file icons provider
    startify.file_icons.provider = 'devicons'

    -- Disable folding on alpha buffer
    vim.cmd [[
      autocmd FileType alpha setlocal nofoldenable
    ]]

    alpha.setup(startify.config)
  end,
}
