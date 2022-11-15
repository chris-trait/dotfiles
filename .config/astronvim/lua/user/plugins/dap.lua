local dap = require "dap"

dap.adapters.chrome = {
   type = "executable",
   command = "node",
   args = { os.getenv "HOME" .. "/opt/vscode-chrome-debug/out/src/chromeDebug.js" },
}

dap.adapters.node2 = {
   type = "executable",
   command = "node",
   args = { os.getenv "HOME" .. "/opt/vscode-node-debug2/out/src/nodeDebug.js" },
}

local dap_typescript = {
   type = "chrome",
   name = "Chrome",
   request = "attach",
   port = 9222,
   console = "integratedTerminal",
   cwd = vim.fn.getcwd(),
   sourceMaps = true,
   restart = true,
   webRoot = "${workspaceFolder}",
}

dap.configurations.typescriptreact = {
   dap_typescript,
}
dap.configurations.typescript = {
   dap_typescript,
}

vim.cmd [[highlight DebugBreakpoint guifg=red]]
vim.cmd [[highlight DebugBreakpointConditional guifg=red]]
vim.cmd [[highlight DebugBreakpointRejected guifg=red]]

dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DebugBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define(
   "DapBreakpointCondition",
   { text = "", texthl = "DebugBreakpointConditional", linehl = "", numhl = "" }
)
vim.fn.sign_define(
   "DapBreakpointRejected",
   { text = "", texthl = "DebugBreakpointRejected", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "debugPC", numhl = "" })
