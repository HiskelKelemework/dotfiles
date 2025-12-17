-- Neovim configuration optimized for QWERTY keyboard
-- File: ~/.config/nvim/init.lua
-- Set leader key to space for QWERTY-friendly access
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.autread = true -- Automatically detect file changes from outside and reload file
-- vim.opt.cmdheight = 0 -- remove gap below nvim status bar
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- save undo history to file
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath 'state' .. '/undo'

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

-- THEME and TRANSPARENCY SETTINGS
vim.cmd 'colorscheme rose-pine'

vim.api.nvim_set_hl(0, 'DiffAdd', {
  bg = '#093413',
  fg = 'NONE',
})

vim.api.nvim_set_hl(0, 'DiffDelete', {
  bg = '#3f0001',
  fg = 'NONE',
})

vim.api.nvim_set_hl(0, 'DiffChange', {
  bg = '#0f2d4d',
  fg = 'NONE',
})

vim.api.nvim_set_hl(0, 'DiffText', {
  bg = '#007acc',
  fg = '#ffffff', -- VS Code highlights changed text with bright fg
  bold = true,
})

--------------------------------------------  LSP -----------------------------------------------------
vim.lsp.enable 'lua_ls'
vim.lsp.enable 'vtsls'

-- This is copied from ChatGPT, works for now.
vim.api.nvim_create_user_command('LspRestart', function()
  local bufnr = vim.api.nvim_get_current_buf()

  for _, client in ipairs(vim.lsp.get_active_clients { bufnr = bufnr }) do
    client.stop()
  end

  -- re-trigger LSP attach
  vim.defer_fn(function()
    vim.cmd 'edit'
  end, 100)
end, {})
