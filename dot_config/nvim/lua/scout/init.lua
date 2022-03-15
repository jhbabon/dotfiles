local core = require("scout.core")
local config = require("scout.config")

local M = {
  -- reexports
  run = core.run,
  signal = core.signal,
  setup = config.setup,
}

return M
