--              AstroNvim Configuration Table
--{ "ellisonleao/gruvbox.nvim" } All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
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

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    setup_handlers = {
      tsserver = function(_, opts) require("typescript").setup { server = opts } end
    },
    -- enable servers that you already have installed without mason
    skip_setup = {
      "sourcekit"
    },
    servers = {
      "sourcekit"
      -- "tsserver",
      -- "sourcekit"
      -- "rust_analyzer",
      -- "pyright"
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
      -- ["<leader>jl"] = { require("hop").hint_lines_skip_whitespace, desc = "Hop to line" },
      -- ["<leader>jj"] = { require("hop").hint_words, desc = "Hop to word" },
      -- ["<leader>jc"] = { require("hop").hint_char2, desc = "Hop to digram" },

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

      ["f"] = {
        function()
          -- require("hop").hint_char1({
          --    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          --    current_line_only = true,
          -- })
        end,
        desc = "Find after cursor",
      },
      ["F"] = {
        function()
          -- require("hop").hint_char1({
          --    direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          --    current_line_only = true,
          -- })
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
      -- ["<leader>jl"] = { require("hop").hint_lines_skip_whitespace, desc = "Hop to line" },
      -- ["<leader>jj"] = { require("hop").hint_words, desc = "Hop to word" },
      -- ["<leader>jc"] = { require("hop").hint_char2, desc = "Hop to digram" },
      -- ["f"] = {
      --    function()
      --       require("hop").hint_char1({
      --          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
      --          current_line_only = true,
      --       })
      --    end,
      --    desc = "Find after cursor",
      -- },
      -- ["F"] = {
      --    function()
      --       require("hop").hint_char1({
      --          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      --          current_line_only = true,
      --       })
      --    end,
      --    desc = "Find after cursor",
      -- },
    },
  },

  -- Configure plugins
  plugins = {
    {
      "goolord/alpha-nvim",
      opts = function(_, opts) -- override the options using lazy.nvim
        opts.section.header.val = { -- change the header section value
          "                                                       _/                      ",
          "   _/_/_/        _/_/        _/_/     _/      _/               _/_/_/  _/_/    ",
          "  _/    _/    _/_/_/_/    _/    _/   _/      _/      _/       _/    _/    _/   ",
          " _/    _/    _/          _/    _/     _/  _/        _/       _/    _/    _/    ",
          "_/    _/      _/_/_/      _/_/         _/          _/       _/    _/    _/     ",
          "                                                                               ",
        }
      end,
    },
    ["p00f/nvim-ts-rainbow"] = { disable = true },
    {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("catppuccin").setup({
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
        })
      end,
    },
    {
      "phaazon/hop.nvim",
      config = function()
        require("hop").setup({})
      end,
    },
    {
      "cormacrelf/dark-notify",
      dependencies = {
        "rktjmp/lush.nvim"
      },
      lazy = false,
      config = function()
        -- vim.cmd.colorscheme'ayu-mirage'
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
    -- {
    --    "mfussenegger/nvim-dap",
    --    config = function()
    --       require "user.plugins.dap"
    --    end,
    -- },
    -- {
    --    "scalameta/nvim-metals",
    --    requires = { "nvim-lua/plenary.nvim" },
    --    config = function()
    --       require("user.plugins.metals")
    --    end,
    -- },
    -- {
    --    "scalameta/nvim-metals",
    --    requires = { "nvim-lua/plenary.nvim" },
    --    config = function()
    --       require "user.plugins.metals"
    --    end,
    -- },
    {
      "jose-elias-alvarez/typescript.nvim",
      after = "mason-lspconfig.nvim",
      config = function()
        require("typescript").setup({
          disable_commands = false
        })
      end,
    },
    -- {
    --    "mxsdev/nvim-dap-vscode-js",
    --    config = function()
    --       require("dap-vscode-js").setup({
    --          debugger_path = "/Users/ck/.local/share/nvim/vscode-js-debug",
    --          adapters = {
    --             "pwa-node",
    --             "pwa-chrome",
    --             "node-terminal",
    --             "pwa-extensionHost",
    --          }, -- which adapters to register in nvim-dap
    --       })
    --
    --       for _, language in ipairs({ "typescriptreact", "typescript", "javascript" }) do
    --          require("dap").configurations[language] = {
    --             {
    --                type = "pwa-node",
    --                request = "launch",
    --                name = "Launch file",
    --                program = "${file}",
    --                cwd = "${workspaceFolder}",
    --             },
    --             {
    --                type = "pwa-node",
    --                request = "attach",
    --                name = "Attach",
    --                processId = require("dap.utils").pick_process,
    --                cwd = "${workspaceFolder}",
    --             },
    --          }
    --       end
    --    end,
    -- },
    { "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" },
    {
      'xbase-lab/xbase',
      run = 'make install', -- make free_space (not recommended, longer build time)
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "neovim/nvim-lspconfig"
      },
      config = function()
        require 'xbase'.setup({}) -- see default configuration bellow
      end
    },
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup function call
      local null_ls = require("null-ls")

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint,
      }
      return config -- return final config table
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      -- ensure_installed = { "lua" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = { "sumneko_lua", "tsserver", "rust_analyzer", "sourcekit" },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      ensure_installed = { "prettier", "stylua" },
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
    require 'lspconfig'.sourcekit.setup {
      root_dir = require "lspconfig.util".root_pattern("Pneumatic.xcodeproj", ".git")
    }
    require 'xbase'.setup({}) -- see default configuration bellow
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
