-- Plugin configuration for vim-fugitive
return {
  "tpope/vim-fugitive",
  config = function()
 -- Ensure vertical diff splits open to the right
    vim.g.fugitive_diff_split = "rightbelow"   -- Keymaps moved to remap.lua
  end,
}
