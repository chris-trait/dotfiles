local utils = require("user.utils")
local colorschemes = {
   dark = "zenbones",
   light = "zenbones",
}
local mode = "dark"

if utils.get_os() == "darwin" then
   local code = os.execute("defaults read -g AppleInterfaceStyle 2> /dev/null")
   mode = code == 0 and "dark" or "light"
end

local config = {
   updater = {
      remote = "origin", -- remote to use
      channel = "stable", -- "stable" or "nightly"
      version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
      branch = "nightly", -- branch name (NIGHTLY ONLY)
      commit = nil, -- commit hash (NIGHTLY ONLY)
      pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
      skip_prompts = false, -- skip prompts about breaking changes
      show_changelog = true, -- show the changelog after performing an update
      auto_reload = false, -- automatically reload and sync packer after a successful update
      auto_quit = false, -- automatically quit the current session after a successful update
   },
   lazy = {
      lockfile = vim.fn.stdpath("config") .. "/../astronvim/lazy-lock.json",
   },
   colorscheme = colorschemes[mode],
   highlights = {
      -- init = { -- this table overrides highlights in all themes
      --   Normal = { bg = "#000000" },
      -- }
      -- duskfox = { -- a table of overrides/changes to the duskfox theme
      --   Normal = { bg = "#000000" },
      -- },
   },
   -- set vim options here (vim.<first_key>.<second_key> = value)
   options = {
      opt = {
         -- set to true or false etc.
         relativenumber = false, -- sets vim.opt.relativenumber
         number = false, -- sets vim.opt.number
         spell = false, -- sets vim.opt.spell
         -- signcolumn = "auto", -- sets vim.opt.signcolumn to auto
         wrap = true, -- sets vim.opt.wrap
         showtabline = 0,
      },
      g = {
         mapleader = " ", -- sets vim.g.mapleader
         autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
         cmp_enabled = true, -- enable completion at start
         autopairs_enabled = true, -- enable autopairs at start
         diagnostics_enabled = true, -- enable diagnostics at start
         status_diagnostics_enabled = true, -- enable diagnostics in statusline
         icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
         ui_notifications_enabled = true, -- disable notifications when toggling UI elements
      },
   },
   -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
   diagnostics = {
      virtual_text = true,
      underline = true,
   },
   lsp = {
      setup_handlers = {
         tsserver = function(_, opts)
            require("typescript").setup({ server = opts })
         end,
      },
      skip_setup = {},
      servers = {},
      formatting = {
         format_on_save = {
            enabled = true, -- enable or disable format on save globally
            allow_filetypes = { -- enable format on save for specified filetypes only
            },
            ignore_filetypes = { -- disable format on save for specified filetypes
               "markdown",
            },
         },
         disabled = { -- disable formatting capabilities for the listed language servers
         },
         timeout_ms = 1000, -- default format timeout
      },
   },
   mappings = {
      -- first key is the mode
      n = {
         -- buffers
         ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
         ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
         ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
         ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
         -- dap
         ["<leader>d"] = { function() end, desc = "+Debug" },
         -- ["<leader>dd"] = { "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
         -- ["<leader>dc"] = { "<cmd>DapContinue<cr>", desc = "Continue" },
         -- ["<leader>di"] = { "<cmd>DapStepInto<cr>", desc = "Step into" },
         -- ["<leader>do"] = { "<cmd>DapStepOut<cr>", desc = "Step out" },
         -- ["<leader>dn"] = { "<cmd>DapStepOver<cr>", desc = "Step over" },
         -- ["<leader>dl"] = { "<cmd>DapShowLog<cr>", desc = "Show log" },
         -- ["<leader>dr"] = { "<cmd>DapShowRepl<cr>", desc = "Show REPL" },
         -- ["<leader>dL"] = { "<cmd>DapLoadLaunchJSON<cr>", desc = "Load launch.json" },
         -- ["<leader>dt"] = { "<cmd>DapTerminate<cr>", desc = "Terminate" },

         -- ["<leader>ds"] = {
         --    function()
         --       local widgets = require("dap.ui.widgets")
         --       local my_sidebar = widgets.sidebar(widgets.scopes)
         --       my_sidebar.open()
         --    end,
         --    desc = "Terminate",
         -- },

         ["<leader>lo"] = {
            function()
               if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
                  vim.cmd([[TypescriptOrganizeImports]])
               elseif vim.bo.filetype == "scala" then
                  vim.cmd("MetalsOrganizeImports")
               else
                  vim.notify("Unsupported filetype.")
               end
            end,
            desc = "Organize imports",
         },
         ["<leader>lm"] = {
            function()
               if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
                  vim.cmd("TypescriptAddMissingImports")
               else
                  vim.notify("Unsupported filetype.")
               end
            end,
            desc = "Add missing imports",
         },
         ["<leader>c"] = {
            function()
               vim.notify("d'oh!")
            end,
            desc = "Do nothing",
         },
         -- Save
         ["<leader>fs"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
      },
      t = {
         -- setting a mapping to false will disable it
         -- ["<esc>"] = false,
      },
      v = {
         -- hop
      },
   },
   -- Configure plugins
   plugins = {
      ["p00f/nvim-ts-rainbow"] = { enabled = false },
      { "astrotheme", enabled = false },
      -- { "rktjmp/shipwright.nvim", lazy = false },
      {
         "mcchrish/zenbones.nvim",
         lazy = false,
         priority = 1000,
         dependencies = {
            "rktjmp/lush.nvim",
         },
      },
      {
         "goolord/alpha-nvim",
         opts = function(_, opts)
            opts.section.header.val = {
               "                                                       _/                      ",
               "   _/_/_/        _/_/        _/_/     _/      _/               _/_/_/  _/_/    ",
               "  _/    _/    _/_/_/_/    _/    _/   _/      _/      _/       _/    _/    _/   ",
               " _/    _/    _/          _/    _/     _/  _/        _/       _/    _/    _/    ",
               "_/    _/      _/_/_/      _/_/         _/          _/       _/    _/    _/     ",
               "                                                                               ",
            }
         end,
      },
      {
         "phaazon/hop.nvim",
         config = function()
            require("hop").setup({})
         end,
         keys = require("user.plugin.hop").keys,
      },
      {
         "cormacrelf/dark-notify",
         lazy = false,
         config = function()
            if require("user.utils").get_os() == "darwin" then
               require("dark_notify").run({
                  schemes = {
                     dark = "zenbones",
                     light = "zenbones",
                  },
               })
            end
         end,
      },
      {
         "ruifm/gitlinker.nvim",
         config = function()
            local default_callbacks = {
               ["github.com"] = require("gitlinker.hosts").get_github_type_url,
            }
            local ok, extra = pcall(require, "user.extra")
            local callbacks = not ok and default_callbacks or extra.gitlinker_callbacks

            require("gitlinker").setup({
               opts = { print_url = false },
               callbacks = callbacks,
            })
         end,
      },
      {
         "jose-elias-alvarez/typescript.nvim",
         after = "mason-lspconfig.nvim",
         config = function()
            require("typescript").setup({
               disable_commands = false,
            })
         end,
      },
      {
         "mxsdev/nvim-dap-vscode-js",
      },
      {
         "xbase-lab/xbase",
         run = "make install", -- make free_space (not recommended, longer build time)
         dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "neovim/nvim-lspconfig",
         },
         config = function()
            require("xbase").setup({}) -- see default configuration bellow
         end,
      },
      -- All other entries override the require("<key>").setup({...}) call for default plugins
      ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
         local null_ls = require("null-ls")
         config.sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.diagnostics.eslint,
         }
         return config -- return final config table
      end,
      treesitter = { -- overrides `require("treesitter").setup(...)`
         -- ensure_installed = { "lua" },
      },
      ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
         ensure_installed = { "sumneko_lua", "tsserver", "rust_analyzer", "sourcekit" },
      },
      ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
         ensure_installed = { "prettier", "stylua" },
      },
      { "sindrets/diffview.nvim", lazy = false, dependencies = { "nvim-lua/plenary.nvim" } },
   },
   luasnip = {
      -- Extend filetypes
      filetype_extend = {
         -- javascript = { "javascriptreact" },
      },
      -- Configure luasnip loaders (vscode, lua, and/or snipmate)
      vscode = {
         -- Add paths for including more VS Code style snippets in luasnip
         paths = {},
      },
   },
   cmp = {
      source_priority = {
         nvim_lsp = 1000,
         luasnip = 750,
         buffer = 500,
         path = 250,
      },
   },
   polish = function()
      vim.api.nvim_create_augroup("xbase", {})
      vim.api.nvim_create_autocmd("FileType", {
         pattern = "swift",
         desc = "load xbase",
         group = "xbase",
         callback = function()
            require("lspconfig").sourcekit.setup({
               root_dir = require("lspconfig.util").root_pattern("Pneumatic.xcodeproj", ".git"),
            })
            require("xbase").setup({}) -- see default configuration bellow
         end,
      })

      vim.api.nvim_create_augroup("js-debug", {})
      vim.api.nvim_create_autocmd("FileType", {
         pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
         desc = "load JS debugging",
         group = "js-debug",
         callback = function()
            require("user.plugin.dap")
         end,
      })

      function serializeTable(val, name, skipnewlines, depth)
         skipnewlines = skipnewlines or false
         depth = depth or 0

         local tmp = string.rep(" ", depth)

         if name then
            tmp = tmp .. name .. " = "
         end

         if type(val) == "table" then
            tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

            for k, v in pairs(val) do
               tmp = tmp .. serializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
            end

            tmp = tmp .. string.rep(" ", depth) .. "}"
         elseif type(val) == "number" then
            tmp = tmp .. tostring(val)
         elseif type(val) == "string" then
            tmp = tmp .. string.format("%q", val)
         elseif type(val) == "boolean" then
            tmp = tmp .. (val and "true" or "false")
         else
            tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
         end

         return tmp
      end

      -- vim.o.background = "dark"
      -- local colorscheme = require("zenbones")
      -- local lushwright = require("shipwright.transform.lush")
      -- local result = lushwright.to_vimscript(colorscheme)
      -- local f = assert(io.open("/Users/ck/zenbones-dark.lua", "w"))
      -- f:write(serializeTable(result))
      -- f:close()
   end,
}

return config
