--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local utils = require "user.utils"
local colorschemes = {
    dark = "zenbones",
    light = "zenbones",
}
local mode = "light"

if utils.get_os() == "darwin" then
    local code = os.execute "defaults read -g AppleInterfaceStyle 2> /dev/null"
    mode = code == 0 and "dark" or "light"
end

local config = {
    -- Configure AstroNvim updates
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
        -- remotes = { -- easily add new remotes to track
        --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
        --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
        --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
        -- },
    },
    -- Set colorscheme to use
    colorscheme = colorschemes[mode],
    -- Add highlight groups in any theme
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
    -- If you need more control, you can use the function()...end notation
    -- options = function(local_vim)
    --   local_vim.opt.relativenumber = true
    --   local_vim.g.mapleader = " "
    --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
    --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
    --
    --   return local_vim
    -- end,

    -- Set dashboard header
    -- header = {
    --         "_________________________________________________/\\/\\___________________",
    --         "_/\\/\\/\\/\\______/\\/\\/\\______/\\/\\/\\____/\\/\\__/\\/\\__________/\\/\\/\\__/\\/\\___",
    --         "_/\\/\\__/\\/\\__/\\/\\/\\/\\/\\__/\\/\\__/\\/\\__/\\/\\__/\\/\\__/\\/\\____/\\/\\/\\/\\/\\/\\/\\_",
    --         "_/\\/\\__/\\/\\__/\\/\\________/\\/\\__/\\/\\____/\\/\\/\\____/\\/\\____/\\/\\__/\\__/\\/\\_",
    --         "_/\\/\\__/\\/\\____/\\/\\/\\/\\____/\\/\\/\\________/\\______/\\/\\/\\__/\\/\\______/\\/\\_",
    --         "________________________________________________________________________",
    -- },

    header = {
        "                                                       _/                      ",
        "   _/_/_/        _/_/        _/_/     _/      _/               _/_/_/  _/_/    ",
        "  _/    _/    _/_/_/_/    _/    _/   _/      _/      _/       _/    _/    _/   ",
        " _/    _/    _/          _/    _/     _/  _/        _/       _/    _/    _/    ",
        "_/    _/      _/_/_/      _/_/         _/          _/       _/    _/    _/     ",
        "                                                                               ",
    },
    -- Default theme configuration
    default_theme = {
        plugins = {
            aerial = true,
            beacon = false,
            bufferline = true,
            cmp = true,
            dashboard = true,
            highlighturl = true,
            hop = true,
            indent_blankline = true,
            lightspeed = false,
            ["neo-tree"] = true,
            notify = true,
            ["nvim-tree"] = true,
            ["nvim-web-devicons"] = true,
            rainbow = true,
            symbols_outline = false,
            telescope = true,
            treesitter = true,
            vimwiki = false,
            ["which-key"] = true,
        },
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
        virtual_text = true,
        underline = true,
    },
    -- Extend LSP configuration
    lsp = {
        -- enable servers that you already have installed without mason
        skip_setup = {
            -- "tsserver",
        },
        servers = {
            -- "pyright"
        },
        lsp = {
            setup_handlers = {
                -- add custom handler
                tsserver = function(_, opts)
                    require("typescript").setup { server = opts }
                end,
            },
        },
        formatting = {
            -- control auto formatting on save
            format_on_save = {
                enabled = true, -- enable or disable format on save globally
                allow_filetypes = { -- enable format on save for specified filetypes only
                    -- "go",
                },
                ignore_filetypes = { -- disable format on save for specified filetypes
                    -- "python",
                },
            },
            disabled = { -- disable formatting capabilities for the listed language servers
                -- "sumneko_lua",
            },
            timeout_ms = 1000, -- default format timeout
            -- filter = function(client) -- fully override the default formatting function
            --   return true
            -- end
        },
        -- easily add or disable built in mappings added during LSP attaching
        mappings = {
            n = {
                -- ["<leader>lf"] = false -- disable formatting keymap
            },
        },
        -- add to the global LSP on_attach function
        -- on_attach = function(client, bufnr)
        -- end,

        -- override the mason server-registration function
        -- server_registration = function(server, opts)
        --   require("lspconfig")[server].setup(opts)
        -- end,

        -- Add overrides for LSP server settings, the keys are the name of the server
        ["server-settings"] = {
            -- example for addings schemas to yamlls
            -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
            --   settings = {
            --     yaml = {
            --       schemas = {
            --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
            --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
            --       },
            --     },
            --   },
            -- },
        },
    },
    -- Mapping data with "desc" stored directly by vim.keymap.set().
    --
    -- Please use this mappings table to set keyboard mapping since this is the
    -- lower level configuration and more robust one. (which-key will
    -- automatically pick-up stored data by this setting.)
    mappings = {
        -- first key is the mode
        n = {
            -- second key is the lefthand side of the map
            -- mappings seen under group name "Buffer"
            ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
            ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
            ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
            ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
            -- hop
            ["<leader>jl"] = { require("hop").hint_lines_skip_whitespace, desc = "Hop to line" },
            ["<leader>jj"] = { require("hop").hint_words, desc = "Hop to word" },
            ["<leader>jc"] = { require("hop").hint_char2, desc = "Hop to digram" },

            -- dap
            -- ["<leader>d"] = { function() end, desc = "+Debug" },
            -- ["<leader>dd"] = { "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
            -- ["<leader>dc"] = { "<cmd>DapContinue<cr>", desc = "Continue" },
            -- ["<leader>di"] = { "<cmd>DapStepInto<cr>", desc = "Step into" },
            -- ["<leader>do"] = { "<cmd>DapStepOut<cr>", desc = "Step out" },
            -- ["<leader>dn"] = { "<cmd>DapStepOver<cr>", desc = "Step over" },
            -- ["<leader>dl"] = { "<cmd>DapShowLog<cr>", desc = "Show log" },
            -- ["<leader>dr"] = { "<cmd>DapShowRepl<cr>", desc = "Show REPL" },
            -- ["<leader>dL"] = { "<cmd>DapLoadLaunchJSON<cr>", desc = "Load launch.json" },
            -- ["<leader>dt"] = { "<cmd>DapTerminate<cr>", desc = "Terminate" },
            --
            -- ["<leader>ds"] = {
            --    function()
            --       local widgets = require "dap.ui.widgets"
            --       local my_sidebar = widgets.sidebar(widgets.scopes)
            --       my_sidebar.open()
            --    end,
            --    desc = "Terminate",
            -- },

            ["gd"] = {
                function()
                    if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
                        vim.cmd "TypescriptGoToSourceDefinition"
                    else
                        vim.lsp.buf.definition()
                    end
                end,
                desc = "Go to definition",
            },
            ["<leader>lo"] = {
                function()
                    if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
                        vim.cmd "TypescriptOrganizeImports"
                    elseif vim.bo.filetype == "scala" then
                        vim.cmd "MetalsOrganizeImports"
                    else
                        vim.notify "Unsupported filetype."
                    end
                end,
                desc = "Organize imports",
            },
            ["<leader>lm"] = {
                function()
                    if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
                        vim.cmd "TypescriptAddMissingImports"
                    else
                        vim.notify "Unsupported filetype."
                    end
                end,
                desc = "Add missing imports",
            },

            ["<leader>c"] = {
                function()
                    vim.notify "d'oh!"
                end,
                desc = "Do nothing",
            },

            ["f"] = {
                function()
                    require("hop").hint_char1 {
                        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
                        current_line_only = true,
                    }
                end,
                desc = "Find after cursor",
            },
            ["F"] = {
                function()
                    require("hop").hint_char1 {
                        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
                        current_line_only = true,
                    }
                end,
                desc = "Find after cursor",
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
            ["<leader>jl"] = { require("hop").hint_lines_skip_whitespace, desc = "Hop to line" },
            ["<leader>jj"] = { require("hop").hint_words, desc = "Hop to word" },
            ["<leader>jc"] = { require("hop").hint_char2, desc = "Hop to digram" },
            ["f"] = {
                function()
                    require("hop").hint_char1 {
                        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
                        current_line_only = true,
                    }
                end,
                desc = "Find after cursor",
            },
            ["F"] = {
                function()
                    require("hop").hint_char1 {
                        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
                        current_line_only = true,
                    }
                end,
                desc = "Find after cursor",
            },
        },
    },
    -- Configure plugins
    plugins = {
        ["p00f/nvim-ts-rainbow"] = { disable = true },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            config = function()
                require("catppuccin").setup {
                    integrations = {
                        ts_rainbow = true,
                        cmp = true,
                        gitsigns = true,
                        nvimtree = true,
                        telescope = true,
                        notify = true,
                        hop = true,
                        which_key = true,
                    },
                }
            end,
        },
        {
            "phaazon/hop.nvim",
            config = function()
                require("hop").setup {}
            end,
        },
        {
            "cormacrelf/dark-notify",
            config = function()
                -- vim.cmd.colorscheme'ayu-mirage'
                if require("user.utils").get_os() == "darwin" then
                    require("dark_notify").run {
                        schemes = {
                            dark = "zenbones",
                            light = "zenbones",
                        },
                    }
                end
            end,
        },
        {
            "ruifm/gitlinker.nvim",
            lazy = false,
            config = function()
                local default_callbacks = {
                    ["github.com"] = require("gitlinker.hosts").get_github_type_url,
                }
                local ok, extra = pcall(require, "user.extra")
                local callbacks = not ok and default_callbacks or extra.gitlinker_callbacks

                require("gitlinker").setup {
                    opts = { print_url = false },
                    callbacks = callbacks,
                }
            end,
        },
        {
            "scalameta/nvim-metals",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
        {
            "jose-elias-alvarez/typescript.nvim",
            after = "mason-lspconfig.nvim",
        },
        {
            "mxsdev/nvim-dap-vscode-js",
            config = function()
                require("dap-vscode-js").setup {
                    debugger_path = "/Users/ck/.local/share/nvim/vscode-js-debug",
                    adapters = {
                        "pwa-node",
                        "pwa-chrome",
                        "node-terminal",
                        "pwa-extensionHost",
                    }, -- which adapters to register in nvim-dap
                }

                for _, language in ipairs { "typescriptreact", "typescript", "javascript" } do
                    require("dap").configurations[language] = {
                        {
                            type = "pwa-node",
                            request = "launch",
                            name = "Launch file",
                            program = "${file}",
                            cwd = "${workspaceFolder}",
                        },
                        {
                            type = "pwa-node",
                            request = "attach",
                            name = "Attach",
                            processId = require("dap.utils").pick_process,
                            cwd = "${workspaceFolder}",
                        },
                    }
                end
            end,
        },
        {
            "nvim-neorg/neorg",
            config = function()
                require("neorg").setup {
                    load = {
                        ["core.defaults"] = {},
                        ["core.norg.dirman"] = {
                            config = {
                                workspaces = {
                                    work = "~/notes/work",
                                    home = "~/notes/home",
                                },
                            },
                        },
                    },
                }
            end,
            dependencies = { "nvim-lua/plenary.nvim" },
        },
        { "ellisonleao/gruvbox.nvim" },
        { "mcchrish/zenbones.nvim",  dependencies = { "rktjmp/lush.nvim" } },
        { "arturgoms/moonbow.nvim" },
        { "ellisonleao/gruvbox.nvim" },
        { "folke/tokyonight.nvim" },
        {
            "klen/nvim-test",
            config = function()
            end,
        },
    },
    -- LuaSnip Options
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
    -- CMP Source Priorities
    -- modify here the priorities of default cmp sources
    -- higher value == higher priority
    -- The value can also be set to a boolean for disabling default sources:
    -- false == disabled
    -- true == 1000
    cmp = {
        source_priority = {
            nvim_lsp = 1000,
            luasnip = 750,
            buffer = 500,
            path = 250,
        },
    },
    -- Modify which-key registration (Use this with mappings table in the above.)
    ["which-key"] = {
        -- Add bindings which show up as group name
        register = {
            -- first key is the mode, n == normal mode
            n = {
                -- second key is the prefix, <leader> prefixes
                ["<leader>"] = {
                    -- third key is the key to bring up next level and its displayed
                    -- group name in which-key top level menu
                    ["b"] = { name = "Buffer" },
                },
            },
        },
    },
    -- This function is run last and is a good place to configuring
    -- augroups/autocommands and custom filetypes also this just pure lua so
    -- anything that doesn't fit in the normal config locations above can go here
    polish = function()
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "scala", "sbt", "java" },
            callback = function()
                local metals_config = require("metals").bare_config()
                metals_config.settings = {
                    showImplicitArguments = true,
                }

                metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
                metals_config.on_attach = function()
                    require("metals").setup_dap()
                end
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })

        local nvim_test_group = vim.api.nvim_create_augroup("nvim-test", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
            callback = function()
                -- require("nvim-test").setup {
                --     runners = {
                --         javascriptreact = "nvim-test.runners.jest",
                --         javascript = "nvim-test.runners.jest",
                --         typescript = "nvim-test.runners.jest",
                --         typescriptreact = "nvim-test.runners.jest",
                --     },
                -- }
                -- require("nvim-test.runners.jest"):setup {
                --     command = "./node_modules/.bin/jest",
                -- }
                require("typescript").setup {}
            end,
            group = nvim_test_group,
        })
    end,
}

return config
