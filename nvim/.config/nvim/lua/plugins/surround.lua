-- Plugin configuration for nvim-surround
return {
  "kylechui/nvim-surround",
  version = "*", -- Use latest release
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",      -- Insert surround in insert mode
        insert_line = "<C-g>S", -- Insert surround on new line
        normal = "ys",          -- Add surround in normal mode
        normal_cur = "yss",     -- Add surround around current line
        normal_line = "yS",     -- Add surround on new line
        visual = "S",           -- Add surround in visual mode
        delete = "ds",          -- Delete surround
        change = "cs",          -- Change surround
      },
    })
  end,
}
