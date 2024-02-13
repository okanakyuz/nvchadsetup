local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add/Remove breakpoint at line",
    },
    ["<leader>dc"] = {
      "<cmd> DapContinue <CR>",
      "Run debugger",
    },
    ["<leader>ds"] = {
      function ()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debug sidebar"
    },

    ["<F5>"] = { "<cmd> DapContinue <CR>", "continue"},
    ["<F4>"] = { "<cmd> DapToggleBreakpoint <CR>", "toggle breakpoint"},
    ["<F9>"] = { "<cmd> DapTerminate <CR>", "stop"},
    ["<F10>"] = { "<cmd> DapStepOver <CR>", "step over"},
    ["<F6>"] = { "<cmd> DapStepInto <CR>", "step into"},
    ["<F7>"] = { "<cmd> DapStepOut <CR>", "step out"},

  }
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function ()
        require("crates").upgrade_all_crates()
      end,
      "Upgrade crates"
    },
  }
}

return M
