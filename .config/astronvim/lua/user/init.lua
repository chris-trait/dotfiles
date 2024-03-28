local utils = require("user.utils")
local theme_light = "kanagawa"
local theme_dark = "kanagawa"
local colorschemes = {
   dark = theme_dark,
   light = theme_light,
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
      ["rose-pine"] = {
         IndentBlanklineChar = {
            fg = mode == "dark" and "#44415a" or "#dfdad9",
         },
         IndentBlanklineSpaceChar = {
            fg = mode == "dark" and "#44415a" or "#dfdad9",
         },
         IndentBlanklineSpaceCharBlankline = {
            fg = mode == "dark" and "#44415a" or "#dfdad9",
         },
         IndentBlanklineIndent1 = {
            fg = mode == "dark" and "#44415a" or "#dfdad9",
         },
         IndentBlanklineIndent2 = {
            fg = mode == "dark" and "#44415a" or "#dfdad9",
         },
      },
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
         indent_blankline_show_current_context = true,
      },
   },
   -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
   diagnostics = {
      virtual_text = true,
      underline = true,
   },
   lsp = {
      setup_handlers = {
         tsserver = function() end,
         -- tsserver = function(_, opts)
         --    require("typescript").setup({ server = opts })
         -- end,
      },
      config = {
         vtsls = function()
            return require("vtsls").lspconfig
         end,
         ["typescript-tools"] = { -- enable inlay hints by default for `typescript-tools`
            settings = {
               separate_diagnostic_server = true,
               complete_function_calls = true,
               tsserver_max_memory = "auto",
               code_lens = "all",
               tsserver_file_preferences = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
               },
               tsserver_plugins = {
                  "@styled/typescript-styled-plugin",
               },
               expose_as_code_action = "all",
               jsx_close_tag = {
                  enable = true,
                  filetypes = { "javascriptreact", "typescriptreact" },
               },
            },
         },
      },
      skip_setup = {},
      servers = {},
      formatting = {
         format_on_save = {
            enabled = false, -- enable or disable format on save globally
            allow_filetypes = { -- enable format on save for specified filetypes only
            },
            ignore_filetypes = { -- disable format on save for specified filetypes
               "markdown",
            },
         },
         disabled = { -- disable formatting capabilities for the listed language servers
            "tsserver",
         },
         timeout_ms = 1000, -- default format timeout
      },
   },
   mappings = {
      -- first key is the mode
      n = {
         ["K"] = { vim.lsp.buf.hover, desc = "Hover" },
         ["<leader>lh"] = { vim.lsp.buf.signature_help, desc = "Signature help" },
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
                  vim.cmd([[TypescriptRemoveUnused]])
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
      {
         "danielfalk/smart-open.nvim",
         branch = "0.2.x",
         dependencies = {
            "kkharji/sqlite.lua",
            -- Only required if using match_algorithm fzf
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
            { "nvim-telescope/telescope-fzy-native.nvim" },
         },
      },
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
         "rose-pine/nvim",
         name = "rose-pine",
         config = function()
            require("rose-pine").setup({
               -- dark_variant = 'moon',
            })
         end,
      },
      {
         "rebelot/kanagawa.nvim",
         lazy = false,
         priority = 1000,
         config = function()
            require("kanagawa").setup({
               colors = {
                  all = {
                     ui = {
                        bg_gutter = "none",
                     },
                  },
               },
               overrides = function(colors)
                  local theme = colors.theme
                  return {
                     LineNr = { bg = "none" },
                     SignColumn = { bg = "none" },
                     FoldColumn = { bg = "none" },

                     -- NormalFloat = { bg = "none" },
                     -- FloatBorder = { bg = "none" },
                     -- FloatTitle = { bg = "none" },

                     -- Save an hlgroup with dark background and dimmed foreground
                     -- so that you can use it where your still want darker windows.
                     -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                     -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                     -- Popular plugins that open floats will link to NormalFloat by default;
                     -- set their background accordingly if you wish to keep them dark and borderless
                     LazyNormal = { bg = theme.ui.bg_m3 },
                     MasonNormal = { bg = theme.ui.bg_m3, fg },
                     Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                     PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                     PmenuSbar = { bg = theme.ui.bg_m1 },
                     PmenuThumb = { bg = theme.ui.bg_p2 },
                     TelescopeTitle = { fg = theme.ui.special, bold = true },
                     TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                     TelescopePromptBorder = { bg = theme.ui.bg_p1 },
                     TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                     TelescopeResultsBorder = { bg = theme.ui.bg_m1 },
                     TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                     TelescopePreviewBorder = { bg = theme.ui.bg_dim },
                  }
               end,
            })
         end,
      },
      {
         "goolord/alpha-nvim",
         config = function()
            require("alpha").setup(require("alpha.themes.theta").config)
         end,
         opts = function(_, opts)
            opts.section.header.val = {
               [[                                  __]],
               [[     ___     ___    ___   __  __ /\_\    ___ ___]],
               [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
               [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
               [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
               [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
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
      { "yioneko/nvim-vtsls", requires = { "neovim/nvim-lspconfig" } },
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
            { "<leader>lu", "<cmd>TSToolsRemoveUnusedImports<cr>", desc = "Remove unused statements" },
            { "<leader>lU", "<cmd>TSToolsRemoveUnused<cr>", desc = "Remove unused statements" },
            { "<leader>li", "<cmd>TSToolsAddMissingImports<cr>", desc = "Remove unused statements" },
            { "<leader>ld", vim.lsp.buf.definition, desc = "Go to Definition " },
            { "gd", vim.lsp.buf.definition, desc = "Go to Definition " },
         },
      },
      {
         "stevearc/conform.nvim",
      },
      -- {
      --    "cormacrelf/dark-notify",
      --    lazy = false,
      --    config = function()
      --       if require("user.utils").get_os() == "darwin" then
      --          require("dark_notify").run({
      --             schemes = {
      --                dark = theme_dark,
      --                light = theme_light,
      --             },
      --          })
      --       end
      --    end,
      -- },
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
         "nvim-telescope/telescope-file-browser.nvim",
         dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
      },
      {
         "mxsdev/nvim-dap-vscode-js",
      },
      {
         "nvim-telescope/telescope.nvim",
         version = false,
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
         keys = {
            -- goto
            { "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definition" },
            { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "Go to references" },
            { "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to implementations" },
            {
               "<leader>fe",
               function()
                  require("telescope").extensions.smart_open.smart_open()
               end,
               desc = "Colorscheme",
            },
            { "<leader>aa", "<cmd>AerialToggle<cr>", desc = "Aerial Toggle" },
            { "<leader>sa", "<cmd>Telescope aerial<cr>", desc = "Colorscheme" },
            -- search
            -- { "sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
            {
               "<leader>sf",
               "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
               desc = "File browser",
            },
            { "<leader>ss", "<cmd>Telescope smart_open<cr>", desc = "Smart open" },
            { "<leader>sc", "<cmd>Telescope colorscheme<sr>", desc = "Colorscheme" },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
            { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
            { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
            { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
            { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
            { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },

            { "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
            { "<leader>lR", vim.lsp.buf.references, desc = "References" },
         },
         -- opts = function()
         --    return {
         --       defaults = {
         --          -- borderchars = {"▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼",  }
         --       }
         --    }
         -- end
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
         ensure_installed = { "sumneko_lua", "tsserver", "rust_analyzer", "sourcekit", "vtsls" },
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

      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("smart_open")

      require("conform").setup({
         format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_fallback = false,
         },
         notify_on_error = true,
         formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            -- Use a sub-list to run only the first available formatter
            javascript = { { "prettier" } },
            typescript = { { "prettier" } },
            typescriptreact = { { "prettier" } },
         },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
         pattern = "*",
         callback = function(args)
            require("conform").format({ bufnr = args.buf })
         end,
      })

      -- vim.api.nvim_create_augroup("js-debug", {})
      -- vim.api.nvim_create_autocmd("FileType", {
      --     pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      --     desc = "load JS debugging",
      --     group = "js-debug",
      --     callback = function()
      --        require("user.plugin.dap")
      --     end,
      -- })
   end,
}

return config
