return {
  "folke/todo-comments.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
    -- Example: Custom keybinding for jumping to specific keywords
    highlight = {
      keyword = "bg", -- Highlight the keyword (e.g., TODO) in the background
      after = "fg",   -- Highlight the text after the keyword
    },
  },
  keys = {
    { "]t", function() require("todo-comments").jump_next({ keywords = { "TODO", "FIX", "WARN", "NOTE", "HACK" } }) end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev({ keywords = { "TODO", "FIX", "WARN", "NOTE", "HACK" } }) end, desc = "Previous todo comment" },
  },
}
