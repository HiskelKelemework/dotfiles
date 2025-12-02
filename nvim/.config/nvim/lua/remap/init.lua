-- Centralized keymap configuration
-- File: ~/.config/nvim/lua/remap.lua

local map = vim.keymap.set

map('n', '<C-d>', '<C-d>zz', { desc = 'Jump down half a page and center cursor vertically' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Jump up half a page and center cursor vertically' })

-- File Explorer (neo-tree)
map('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle file explorer' })
map('n', '<leader>egs', ':Neotree git_status<CR>', { desc = 'Toggle git status tree' })

-- Telescope
map('n', '<leader>sh', '<cmd>Telescope help_tags<CR>', { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', '<cmd>Telescope keymaps<CR>', { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', '<cmd>Telescope find_files hidden=true <CR>', { desc = '[S]earch [F]iles' })
map('n', '<leader>ss', '<cmd>Telescope builtin<CR>', { desc = '[S]earch [S]elect Telescope' })
map('n', '<leader>sw', '<cmd>Telescope grep_string<CR>', { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', '<cmd>Telescope live_grep<CR>', { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', '<cmd>Telescope diagnostics<CR>', { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', '<cmd>Telescope resume<CR>', { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', '<cmd>Telescope oldfiles<CR>', { desc = '[S]earch Recent Files ("." for repeat)' })
map('n', '<leader><leader>', '<cmd>Telescope buffers<CR>', { desc = '[ ] Find existing buffers' })
map('n', 'gd', '<cmd>Telescope lsp_type_definitions<CR>', { buffer = bufnr, desc = 'Go to type definition' })

map('n', '<leader>/', function()
  local builtin = require 'telescope.builtin'
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
map('n', '<leader>s/', function()
  local builtin = require 'telescope.builtin'
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
map('n', '<leader>sn', function()
  local builtin = require 'telescope.builtin'
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- Git (fugitive)
local opts = { noremap = true, silent = true }

-- vim-fugitive keymappings
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', opts) -- Open Git status
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add %<CR>', opts) -- Stage current file
vim.api.nvim_set_keymap('v', '<leader>ga', ':Git add -p<CR>', opts) -- Stage selected hunk
vim.api.nvim_set_keymap('n', '<leader>gu', ':Git restore --staged %<CR>', opts) -- Unstage current file
vim.api.nvim_set_keymap('v', '<leader>gu', ':Git restore --staged -p<CR>', opts) -- Unstage selected hunk
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', opts) -- Open commit window
vim.api.nvim_set_keymap('n', '<leader>gca', ':Git commit -a<CR>', opts) -- Commit all changes (auto-stage)
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<CR>', opts) -- Push to remote
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiffsplit<CR>', opts) -- View diff for current file

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Window resizing
map('n', '<leader>rh', ':vertical resize +5<CR>', { desc = 'Increase window width' })
map('n', '<leader>rl', ':vertical resize -5<CR>', { desc = 'Decrease window width' })
map('n', '<leader>rk', ':resize +5<CR>', { desc = 'Increase window height' })
map('n', '<leader>rj', ':resize -5<CR>', { desc = 'Decrease window height' })

-- General
map('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
map('n', '<leader>q', ':mksession!<CR> :q<CR>', { desc = 'Quit' })
map('n', '<leader>.', '@:', { desc = 'Repeat last command' })
map('n', '<Esc>', '<cmd>noh<CR><Esc>', { silent = true }) -- no highlight when pressing escape after searching

-- Quick fix list
map('n', '<leader>co', ':copen<CR>', { desc = 'Open Quick fix list' })
map('n', '<leader>cn', ':cnext<CR>', { desc = 'Move next in the Quick fix list' })
map('n', '<leader>cp', ':cprev<CR>', { desc = 'Move to previous in the Quick fix list' })
map('n', '<leader>cc', ':cclose<CR>', { desc = 'Close quick fix list' })

-- Keybindings for diagnostics
map('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>', { desc = 'Show diagnostics in float' })
