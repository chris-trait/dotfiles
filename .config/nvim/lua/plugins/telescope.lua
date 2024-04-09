return {
   {
      "danielfalk/smart-open.nvim",
      branch = "0.2.x",
      dependencies = {
         "kkharji/sqlite.lua",
         { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
         { "nvim-telescope/telescope-fzy-native.nvim" },
      },
   },
   {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
   },
   {
      "nvim-telescope/telescope.nvim",
      version = false,
      dependencies = {
         "nvim-telescope/telescope-file-browser.nvim",
         "danielfalk/smart-open.nvim",
      },
      opts = {
         extensions = {
            smart_open = {
               show_scores = true,
               open_buffer_indicators = { previous = "👀", others = "🙈" },
            },
            file_browser = {
               -- theme = "ivy",
               -- disables netrw and use telescope-file-browser in its place
               hijack_netrw = true,
               mappings = {
                  ["i"] = {
                     -- your custom insert mode mappings
                  },
                  ["n"] = {
                     -- your custom normal mode mappings
                  },
               },
            },
         },
         defaults = {
            preview = {
               mime_hook = function(filepath, bufnr, opts)
                  local is_image = function(filepath)
                     local image_extensions = { "png", "jpg", "jpeg" } -- Supported image formats
                     local split_path = vim.split(filepath:lower(), ".", { plain = true })
                     local extension = split_path[#split_path]
                     return vim.tbl_contains(image_extensions, extension)
                  end
                  if is_image(filepath) then
                     local term = vim.api.nvim_open_term(bufnr, {})
                     local function send_output(_, data, _)
                        for _, d in ipairs(data) do
                           vim.api.nvim_chan_send(term, d .. "\r\n")
                        end
                     end
                     vim.fn.jobstart({
                        "catimg",
                        filepath, -- Terminal image viewer command
                     }, { on_stdout = send_output, stdout_buffered = true, pty = true })
                  else
                     require("telescope.previewers.utils").set_preview_message(
                        bufnr,
                        opts.winid,
                        "Binary cannot be previewed"
                     )
                  end
               end,
            },
         },
      },
      config = function(_, opts)
         require("telescope").load_extension("file_browser")
         require("telescope").load_extension("smart_open")
         require("telescope").setup(opts)
      end,
      keys = {
         -- goto
         { "<Leader>fd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definition" },
         { "<Leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "Go to references" },
         { "<Leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to implementations" },
         { "<Leader>aa", "<cmd>AerialToggle<cr>", desc = "Aerial Toggle" },
         { "<Leader>sa", "<cmd>Telescope aerial<cr>", desc = "Colorscheme" },
         -- search
         -- { "sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
         {
            "<Leader>sf",
            "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
            desc = "File browser",
         },
         { "<Leader>sc", "<cmd>Telescope colorscheme<sr>", desc = "Colorscheme" },
         { "<Leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
         { "<Leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
         { "<Leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
         { "<Leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
         { "<Leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
         { "<Leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
         { "<Leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },

         { "<Leader>lr", vim.lsp.buf.rename, desc = "Rename" },
         { "<Leader>lR", vim.lsp.buf.references, desc = "References" },

         { "<Leader>ss", "<cmd>Telescope smart_open<cr>", desc = "Smart open" },
         { "<Leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>" },
      },
   },
}
