---@type LazySpec
return {
   {
      "linrongbin16/gitlinker.nvim",
      cmd = "GitLink",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {},
      keys = {
         { "<leader>yg", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
         { "<leader>yb", "<cmd>GitLink blame<cr>", mode = { "n", "v" }, desc = "Yank git blame" },
         { "<leader>yc", "<cmd>GitLink current_branch<cr>", mode = { "n", "v" }, desc = "Yank git current" },
         { "<leader>yd", "<cmd>GitLink default_branch<cr>", mode = { "n", "v" }, desc = "Yank git default" },
      },
   },
}
