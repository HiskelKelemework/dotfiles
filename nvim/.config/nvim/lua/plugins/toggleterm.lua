return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = 15,
      open_mapping = [[<C-\>]], -- toggles terminal with Ctrl + \
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      direction = 'horizontal', -- or "vertical" | "float" | "tab"
      close_on_exit = true,
      shell = vim.o.shell,
    }

    vim.keymap.set({ 'n', 't' }, '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
  end,
}
