return {
  { "folke/tokyonight.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim",         name = "catppuccin" },
  {
    'Mofiqul/vscode.nvim',
    config = function()
      vim.cmd([[colorscheme vscode]])
    end,
  }
}
