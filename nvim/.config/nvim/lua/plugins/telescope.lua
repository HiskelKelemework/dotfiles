return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = {
          '%.git/',
          '.next',
          '.npm',
          'coverage',
          '__mocks__',
          'node_modules',
        },
        mappings = {
          i = {
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' },
        },
        colorscheme = {
          enable_preview = true,
        },
      },
    }
  end,
}
