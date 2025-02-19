local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function custom_picker(opts)
  local items = {
    { name = "Item 1", description = "Description 1" },
    { name = "Item 2", description = "Description 2" },
    { name = "Item 3", description = "Description 3" },
  }

  pickers.new(opts, {
    prompt_title = "My Custom Title"
  })
end

local M = {}

function M.setup()
  require('telescope').register_extension({
    exports = {
      my_picker = custom_picker
    }
  })
end

return M
