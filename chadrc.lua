---@type ChadrcConfig
local M = {}



M.ui = { 
  theme = 'tokyodark', 
  transparency = true,
  tabufline = {
    enabled= false,
  },
  statusline = {
    theme = 'minimal'
  },
   
}
M.plugins = 'custom.plugins'
M.mappings = require("custom.mappings")

return M
