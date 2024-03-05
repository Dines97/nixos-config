require('neodev').setup({
  override = function(root_dir, library)
    if root_dir == '/etc/nixos' then
      -- require('notify')('Neodev activated')
      vim.notify('Neodev activated', vim.log.levels.INFO)
      library.enabled = true
      library.plugins = true
    end
  end
})
