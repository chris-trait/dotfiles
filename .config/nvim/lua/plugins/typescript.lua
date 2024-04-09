---@type LazySpec
return {
   {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
      -- get AstroLSP provided options like `on_attach` and `capabilities`
      opts = function()
         local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
         if astrolsp_avail then
            return astrolsp.lsp_opts("typescript-tools")
         end
      end,
      keys = {
         { "<Leader>lu", "<cmd>TSToolsRemoveUnusedImports<cr>", desc = "Remove unused statements" },
         { "<Leader>lU", "<cmd>TSToolsRemoveUnused<cr>", desc = "Remove unused statements" },
         { "<Leader>li", "<cmd>TSToolsAddMissingImports<cr>", desc = "Remove unused statements" },
         {
            "<Leader>lo",
            function()
               if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
                  vim.cmd([[TSToolsOrganizeImports]])
                  vim.cmd([[TSToolsRemoveUnused]])
               else
                  vim.notify("Unsupported filetype.")
               end
            end,
            desc = "Organize imports",
         },
      },
   },
}
