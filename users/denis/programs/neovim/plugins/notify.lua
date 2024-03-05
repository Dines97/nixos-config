local stages = require('notify.stages.static')('top_down')
local notify = require('notify')

notify.setup({
  render = 'compact',
  stages = {
    function(...)
      local opts = stages[1](...)
      if opts then
        opts.border = 'none'
      end
      return opts
    end,
    unpack(stages, 2)
  },
  timeout = 5000
})

vim.notify = notify
