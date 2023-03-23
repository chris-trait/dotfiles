return {
   keys = {
      {
         "<leader>jl",
         function()
            require("hop").hint_lines_skip_whitespace()
         end,
         desc = "Hop to line",
      },
      {
         "<leader>jj",
         function()
            require("hop").hint_words()
         end,
         desc = "Hop to word",
      },
      {
         "<leader>jc",
         function()
            require("hop").hint_char2()
         end,
         desc = "Hop to digram",
      },
      {
         "f",
         function()
            require("hop").hint_char1({
               direction = require("hop.hint").HintDirection.AFTER_CURSOR,
               current_line_only = true,
            })
         end,
         desc = "Find after cursor",
      },
      {
         "F",
         function()
            require("hop").hint_char1({
               direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
               current_line_only = true,
            })
         end,
         desc = "Find after cursor",
      },

      {
         "<leader>jl",
         function()
            require("hop").hint_lines_skip_whitespace()
         end,
         mode = "v",
         desc = "Hop to line",
      },
      {
         "<leader>jj",
         function()
            require("hop").hint_words()
         end,
         mode = "v",
         desc = "Hop to word",
      },
      {
         "<leader>jc",
         function()
            require("hop").hint_char2()
         end,
         mode = "v",
         desc = "Hop to digram",
      },
      {
         "f",
         function()
            require("hop").hint_char1({
               direction = require("hop.hint").HintDirection.AFTER_CURSOR,
               current_line_only = true,
            })
         end,
         mode = "v",
         desc = "Find after cursor",
      },
      {
         "F",
         function()
            require("hop").hint_char1({
               direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
               current_line_only = true,
            })
         end,
         mode = "v",
         desc = "Find after cursor",
      },
   },
}
