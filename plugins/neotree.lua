local M = {}

function M.setup()
  local neotree = require('neo-tree')
  neotree.setup({
    filesystem = {
      follow_current_file = { enabled = false, leave_dirs_open = false },
    },
    buffers = {
      follow_current_file = { enabled = true,  leave_dirs_open = false },
    },
    default_component_configs = {
      file_size      = { enabled = false },
      type           = { enabled = false },
      last_modified  = { enabled = false },
      created        = { enabled = false },
      symlink_target = { enabled = false },
    },
  })
end

return M

