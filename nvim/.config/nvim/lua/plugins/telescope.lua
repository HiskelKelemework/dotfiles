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
        colorscheme = {
          enable_preview = true,
        },
      },
    }
  end,
}
