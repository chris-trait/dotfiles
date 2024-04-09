return {
   {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      lazy = false,
   },
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-cmdline",
      },
      lazy = false,
      opts = function(_, opts)
         local cmp = require("cmp")
         opts.sources = cmp.config.sources({
            { name = "nvim_lsp_signature_help", priority = 1000 },
            { name = "nvim_lsp", priority = 1000 },
            { name = "luasnip", priority = 750 },
            { name = "buffer", priority = 500 },
            { name = "path", priority = 250 },
            { name = "emoji", priority = 700 }, -- add new source
         })
      end,
   },
}
