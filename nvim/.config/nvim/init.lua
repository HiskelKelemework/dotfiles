-- Neovim configuration optimized for QWERTY keyboard
-- File: ~/.config/nvim/init.lua
-- Set leader key to space for QWERTY-friendly access
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic settings for performance and usability
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 2 -- 2 spaces for tabs
vim.opt.shiftwidth = 2 -- 2 spaces for indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart indentation
vim.opt.wrap = false -- Disable line wrap
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.cursorline = true -- Highlight current line
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor
-- yank to vim register by default
-- vim.opt.clipboard = 'unnamed' -- Sync with system clipboard

-- set ripgrep to be the default grep
vim.o.grepprg = 'rg --vimgrep --smart-case'
vim.o.grepformat = '%f:%l:%c:%m'

-- You might need to set other highlight groups to NONE as well for full transparency
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- enable matchit to enhance brace/parenthesis matching
vim.g.loaded_matchit = 1
vim.cmd 'packadd matchit'

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup 'plugins'

-- setup folding to use nvim_treesitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99

require 'remap'

-- VSCode Dark+ inspired diff colors for fugitive.nvim
vim.api.nvim_set_hl(0, 'DiffAdd', {
  bg = '#2b473e', -- VSCode-like green/teal for additions
  fg = '#d4d4d4', -- Light gray/white for text
  ctermbg = 23, -- Dark teal (~#2b473e) for 256-color terminals
  ctermfg = 252, -- Light gray for terminals
})

vim.api.nvim_set_hl(0, 'DiffDelete', {
  bg = '#4a1d2a', -- VSCode-like red for deletions
  fg = '#d4d4d4',
  ctermbg = 52, -- Dark red (~#4a1d2a) for terminals
  ctermfg = 252,
})

vim.api.nvim_set_hl(0, 'DiffChange', {
  bg = '#2b3a55', -- VSCode-like blue for changed lines
  fg = '#d4d4d4',
  ctermbg = 24, -- Dark blue (~#2b3a55) for terminals
  ctermfg = 252,
})

vim.api.nvim_set_hl(0, 'DiffText', {
  bg = '#3f4a6b', -- Slightly lighter blue for modified text within changes
  fg = '#d4d4d4',
  ctermbg = 25, -- Slightly lighter blue for terminals
  ctermfg = 252,
})

-- THEME and TRANSPARENCY SETTINGS
vim.cmd 'colorscheme gruvbox'
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
-- folke/ZenMode background transparency
vim.api.nvim_set_hl(0, 'ZenBg', { bg = 'NONE' })
-- Make sign column and fold column transparent
-- fold column is the column that shows the fold markers, left of the line number column
-- sign column is the column that shows git/diff/diagnostic signs, left of the fold column
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'NONE' })
