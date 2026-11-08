return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  config = function()
    local jdtls = require 'jdtls'

    local function start_jdtls(bufnr)
      vim.bo[bufnr].shiftwidth = 4
      vim.bo[bufnr].tabstop = 4
      vim.bo[bufnr].softtabstop = 4
      vim.bo[bufnr].expandtab = true

      -- Prefer the enclosing project root; fall back to the file's own directory
      -- so standalone files (e.g. leetcode practice) still get jdtls.
      local root_dir = vim.fs.root(bufnr, {
        'gradlew',
        'mvnw',
        'pom.xml',
        'build.gradle',
        'build.gradle.kts',
        '.git',
      }) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
      if not root_dir then
        return
      end

      local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

      -- vim.lsp.config('*') only applies to servers started via vim.lsp.enable,
      -- so build the capabilities here explicitly.
      local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('blink.cmp').get_lsp_capabilities())

      jdtls.start_or_attach {
        cmd = { 'jdtls', '-data', workspace_dir },
        root_dir = root_dir,
        capabilities = capabilities,
        init_options = {
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
        },
        settings = {
          java = {
            -- configuration = { runtimes = { { name = 'JavaSE-17', path = '/path/to/jdk17' } } },
          },
        },
      }
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('jdtls-start', { clear = true }),
      pattern = 'java',
      callback = function(args)
        start_jdtls(args.buf)
      end,
    })

    -- The buffer that triggered the lazy load has already fired FileType,
    -- so start it manually. start_or_attach reuses an existing client,
    -- so a double call is harmless.
    start_jdtls(vim.api.nvim_get_current_buf())
  end,
}
