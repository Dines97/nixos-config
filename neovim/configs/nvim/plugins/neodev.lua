require('neodev').setup({
  override = function(root_dir, library)
    if root_dir == '/etc/nixos' then
      require('notify')('Neodev activated')
      library.enabled = true
      library.plugins = true
    end
  end
})
