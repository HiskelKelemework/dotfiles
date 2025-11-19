return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Load on buffer read or new file
  opts = {
    signs = {
      add = { text = "│" }, -- Sign for added lines
      change = { text = "│" }, -- Sign for changed lines
      delete = { text = "_" }, -- Sign for deleted lines
      topdelete = { text = "‾" }, -- Sign for top of deleted block
      changeddelete = { text = "~" }, -- Sign for changed and deleted lines
      untracked = { text = "┆" }, -- Sign for untracked files
    },
    current_line_blame = true, -- Optional: Show blame info at end of line
    signcolumn = true, -- Show signs in the sign column
    numhl = false, -- Highlight line numbers
    linehl = false, -- Highlight lines
    word_diff = false, -- Enable word-level diff
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      -- Keybindings for navigation
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Navigate to next hunk
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Next Git Hunk")

      -- Navigate to previous hunk
      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Previous Git Hunk")

      -- Optional: Additional useful keybindings
      map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Hunk")
      map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Hunk")
      map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Hunk")
      map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, "Blame Line")
    end,
  },
}
