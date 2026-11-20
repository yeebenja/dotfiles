return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  config = function()
    local jdtls = require 'jdtls'

    -- Resolve an installed JDK by major version (macOS). Returns nil if absent.
    local function java_home(version)
      local res = vim.system({ '/usr/libexec/java_home', '-v', tostring(version) }, { text = true }):wait()
      if res.code ~= 0 then
        return nil
      end
      local home = vim.trim(res.stdout or '')
      -- java_home falls back to another JDK when the requested one is missing,
      -- so confirm the match from the JDK's own release file.
      local release = io.open(home .. '/release', 'r')
      if not release then
        return nil
      end
      local content = release:read '*a'
      release:close()
      if not content:match('JAVA_VERSION="' .. version .. '[%."]') then
        return nil
      end
      return home
    end

    -- jdtls itself needs Java 21+ to run. The shell's JAVA_HOME may point at an
    -- older JDK (the launcher would then refuse to start), so pick one explicitly.
    local jdtls_java_home = java_home(21) or java_home(25)

    -- JDKs jdtls may use to compile/resolve projects, keyed by execution environment.
    local runtimes = {}
    for _, version in ipairs { 11, 17, 21, 25 } do
      local home = java_home(version)
      if home then
        table.insert(runtimes, { name = 'JavaSE-' .. version, path = home, default = version == 21 or nil })
      end
    end

    -- Mason's bin dir is only on PATH inside nvim; use the absolute path when present.
    local jdtls_bin = vim.fn.stdpath 'data' .. '/mason/bin/jdtls'
    if vim.fn.executable(jdtls_bin) ~= 1 then
      jdtls_bin = 'jdtls'
    end

    local function start_jdtls(bufnr)
      vim.bo[bufnr].shiftwidth = 4
      vim.bo[bufnr].tabstop = 4
      vim.bo[bufnr].softtabstop = 4
      vim.bo[bufnr].expandtab = true

      -- Library sources opened via go-to-definition (jdt:// buffers) attach to
      -- the client that requested them; don't start a second server for those.
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match '^jdt://' then
        return
      end

      if not jdtls_java_home then
        vim.notify_once('nvim-jdtls: no JDK 21+ found (jdtls needs one to run)', vim.log.levels.ERROR)
        return
      end

      -- Prefer the enclosing project root; fall back to the file's own directory
      -- so standalone files (e.g. leetcode practice) still get jdtls.
      local root_dir = vim.fs.root(bufnr, {
        'gradlew',
        'mvnw',
        'pom.xml',
        'build.gradle',
        'build.gradle.kts',
        '.git',
      }) or vim.fs.dirname(bufname)
      if not root_dir then
        return
      end

      local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

      -- vim.lsp.config('*') only applies to servers started via vim.lsp.enable,
      -- so build the capabilities here explicitly.
      local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('blink.cmp').get_lsp_capabilities())

      jdtls.start_or_attach {
        cmd = {
          jdtls_bin,
          '--java-executable',
          jdtls_java_home .. '/bin/java',
          -- Keep Eclipse metadata (.project, .classpath, .settings) in the jdtls
          -- workspace dir instead of littering the project's git tree.
          '--jvm-arg=-Djava.import.generatesMetadataFilesAtProjectRoot=false',
          '-data',
          workspace_dir,
        },
        root_dir = root_dir,
        capabilities = capabilities,
        init_options = {
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
        },
        settings = {
          java = {
            configuration = { runtimes = runtimes },
            import = {
              gradle = {
                enabled = true,
                wrapper = { enabled = true },
                -- JVM for the Gradle daemon during project import.
                java = { home = jdtls_java_home },
              },
            },
            -- Download library sources so gd lands in real source, not decompiled stubs.
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
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
