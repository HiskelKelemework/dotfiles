return {
  -- Command and arguments to start the server
  cmd = { 'rust-analyzer' },

  -- Filetypes to automatically attach to
  filetypes = { 'rust' },

  -- Project root detection
  -- rust-analyzer primarily relies on Cargo projects
  root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },

  -- Server-specific settings
  -- Docs: https://rust-analyzer.github.io/manual.html#configuration
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },

      checkOnSave = true,

      diagnostics = {
        enable = true,
      },

      procMacro = {
        enable = true,
      },

      inlayHints = {
        bindingModeHints = {
          enable = true,
        },
        closureReturnTypeHints = {
          enable = 'with_block',
        },
        lifetimeElisionHints = {
          enable = 'skip_trivial',
        },
        typeHints = {
          enable = true,
        },
      },
    },
  },
}
