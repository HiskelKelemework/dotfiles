return {
  -- Command to start the server
  cmd = { 'vtsls', '--stdio' },

  -- Filetypes it should attach to
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },

  -- How to detect the project root (very important for correct TS config resolution)
  root_markers = {
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
    '.git',
  },
}
