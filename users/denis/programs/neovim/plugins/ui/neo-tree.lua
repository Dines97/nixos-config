require('neo-tree').setup({
  enable_normal_mode_for_inputs = true,
  event_handlers = {
    {
      event = 'neo_tree_popup_input_ready',
      ---@param input NuiInput
      handler = function(input)
        -- enter input popup with normal mode by default.
        vim.cmd('stopinsert')
      end
    }
  }

})
